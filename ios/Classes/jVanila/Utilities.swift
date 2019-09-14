//
//  Utilities.swift
//  shopify
//
//  Created by Joseph jose on 25/08/19.
//

import UIKit
import ShopApp_Gateway
import MobileBuySDK

extension Checkout: JSONConvertible {
    
    var payCheckout: PayCheckout {
        let payItems = lineItems.map { item in
            PayLineItem(price: item.price!, quantity: item.quantity)
        }
        let payAddress = PayAddress(addressLine1: shippingAddress?.address, addressLine2: shippingAddress?.secondAddress, city: shippingAddress?.city, country: shippingAddress?.country, province: shippingAddress?.state, zip: shippingAddress?.zip, firstName: shippingAddress?.firstName, lastName: shippingAddress?.lastName, phone: shippingAddress?.phone, email: nil)
        
        return PayCheckout(
            id: id,
            lineItems: payItems,
            discount: nil,
            shippingAddress: payAddress,
            shippingRate: shippingLine?.payShippingRate,
            subtotalPrice: subtotalPrice!,
            needsShipping: true,
            totalTax: Decimal(0),
            paymentDue: totalPrice!
        )
    }
    
    convenience init(from checkout:String?) {
        
        self.init()
        guard checkout != nil else {
            
            return
        }
        do {
            if let checkoutJSON = try JSONSerialization.jsonObject(with: checkout!.data(using: .utf8)!, options: .allowFragments) as? Dictionary<String, String> {
                
                self.id = checkoutJSON["id"]!
                self.webUrl = checkoutJSON["webUrl"]!
                if let _subtotalPrice = checkoutJSON["subtotalPrice"] {
                    
                    self.subtotalPrice = Decimal(string:_subtotalPrice)
                }
                if let _totalPrice = checkoutJSON["totalPrice"] {
                    
                    self.totalPrice = Decimal(string:_totalPrice)
                }
                self.currencyCode = checkoutJSON["currencyCode"]
                if let _shippingLine = checkoutJSON["shippingLine"] {
                    
                    self.shippingLine = ShippingRate(from: _shippingLine)
                }
                if let _shippingAddress = checkoutJSON["shippingAddress"] {
                    
                    self.shippingAddress = Address(addressJSON: _shippingAddress)
                }
                var _availableShippingRates:[ShippingRate]?
                var _lineItems = [LineItem]()
                
                
                if let _dataString = checkoutJSON["availableShippingRates"] {
                    if let _availableShippingRatesArray = try JSONSerialization.jsonObject(with: _dataString.data(using: .utf8)!, options: .allowFragments) as? [Dictionary<String, String>] {
                        
                        for asr in _availableShippingRatesArray {
                            
                            let srJSON = try JSONSerialization.data(withJSONObject: asr, options: .prettyPrinted)
                            let jsonString = String(data: srJSON, encoding: .utf8)!
                            let _sr = ShippingRate(from: jsonString)
                            if _availableShippingRates == nil {
                                
                                _availableShippingRates = [ShippingRate]()
                            }
                            _availableShippingRates?.append(_sr)
                        }
                    }
                    self.availableShippingRates = _availableShippingRates
                }
                if let _dataString = checkoutJSON["lineItems"] {
                    if let lineItemsArray = try JSONSerialization.jsonObject(with: _dataString.data(using: .utf8)!, options: .allowFragments) as? [Dictionary<String, String>] {
                        
                        for li in lineItemsArray {
                            
                            let liJSON = try JSONSerialization.data(withJSONObject: li, options: .prettyPrinted)
                            let jsonString = String(data: liJSON, encoding: .utf8)!
                            let _li = LineItem(from: jsonString)
                            _lineItems.append(_li)
                        }
                    }
                    self.lineItems = _lineItems
                }
            }
        }
        catch {
            
            print("Error in converting Checkout JSON string to a valid JSON object!")
        }
    }
    
    func toDictionary() -> [String:AnyObject] {
        
        return ["id":self.id as AnyObject, "webUrl":self.webUrl as AnyObject , "subtotalPrice":self.subtotalPrice as AnyObject , "totalPrice":self.totalPrice as AnyObject , "shippingLine":self.shippingLine?.toDictionary() as AnyObject , "shippingAddress":self.shippingAddress?.toDictionary() as AnyObject , "currencyCode":self.currencyCode as AnyObject, "availableShippingRates": ShippingRate.toDictionaryArray(source: self.availableShippingRates) as AnyObject, "availableShippingRates": LineItem.toDictionaryArray(source: self.lineItems) as AnyObject ]
    }
}

extension ShippingRate: JSONConvertible {
    var payShippingRate: PayShippingRate {
        return PayShippingRate(
            handle: handle,
            title: title!,
            price: Decimal(string: price!)!
        )
    }
    
    convenience init(from shippngRate:String?) {
        self.init()
        guard shippngRate != nil else {
            return
        }
        do {
            if let addressJSONDict = try JSONSerialization.jsonObject(with: shippngRate!.data(using: .utf8)!, options: .allowFragments) as? Dictionary<String, String> {
                
                self.title = addressJSONDict["title"]
                self.price = addressJSONDict["price"]
                self.handle = addressJSONDict["handle"]!
            }
        }
        catch {
            
            print("Error in converting address JSON string to a valid JSON object!")
        }
    }
    
    func toDictionary() -> [String:AnyObject] {
        
        return ["title":self.title as AnyObject, "price":self.price as AnyObject, "handle":self.handle as AnyObject]
    }
    
    static func toDictionaryArray(source objectArray:[Any]?) -> [[String : AnyObject]] {
        
        if let sourceArray = objectArray as? [ShippingRate] {
            var retArray = [[String:AnyObject]]()
            for anItem in sourceArray {
                
                let newItem = anItem.toDictionary()
                retArray.append(newItem)
                
            }
            return retArray
        }
        else {
            
            return [["":"" as AnyObject]]
        }
    }
}

protocol JSONConvertible {
    
    func toDictionary() -> [String:AnyObject]
    
    static func toDictionaryArray(source objectArray:[Any]?) -> [[String:AnyObject]]
    
    func toJSONString() -> String?
}

extension JSONConvertible {
    
    func toJSONString() -> String? {
        
        do {
            let data = try JSONSerialization.data(withJSONObject: self.toDictionary(),  options: .prettyPrinted)
            let resStr = String.init(data: data, encoding: .utf8) ?? ""
            return resStr
        } catch {
            
            print("Error in converting Object to JSON")
            return nil
        }
    }
    
    static func toDictionaryArray(source objectArray:[Any]?) -> [[String : AnyObject]] {
        return [["":"" as AnyObject]]
    }
}

extension VariantOption:JSONConvertible {
    
    convenience init(from variantOptionJSON:String?) {
        self.init()
        guard variantOptionJSON != nil else {
            return
        }
        do {
            if let variantOptionJSONDict = try JSONSerialization.jsonObject(with: variantOptionJSON!.data(using: .utf8)!, options: .allowFragments) as? Dictionary<String, String> {
                
                self.name = variantOptionJSONDict["name"] ?? ""
                self.value = variantOptionJSONDict["value"] ?? ""
            }
        }
        catch {
            
            print("Error in converting address JSON string to a valid JSON object!")
        }
    }
    
    func toDictionary() -> [String:AnyObject] {
        
        return ["name":self.name as AnyObject, "value":self.value as AnyObject]
    }
    
    static func toDictionaryArray(source objectArray:[Any]?) -> [[String : AnyObject]] {
        
        if let sourceArray = objectArray as? [VariantOption] {
            var retArray = [[String:AnyObject]]()
            for variantOption in sourceArray {
                
                let newVariantOption = variantOption.toDictionary()
                retArray.append(newVariantOption)
                
            }
            return retArray
        }
        else {
            
            return [["":"" as AnyObject]]
        }
    }
}

extension Image:JSONConvertible {
    
    convenience init(from imageJSON:String?) {
        self.init()
        guard imageJSON != nil else {
            return
        }
        do {
            if let imageJSONDict = try JSONSerialization.jsonObject(with: imageJSON!.data(using: .utf8)!, options: .allowFragments) as? Dictionary<String, Any> {
                
                self.id = imageJSONDict["id"] as? String ?? ""
                self.src = imageJSONDict["src"] as? String
                self.imageDescription = imageJSONDict["imageDescription"] as? String
            }
        }
        catch {
            
            print("Error in converting address JSON string to a valid JSON object!")
        }
    }
    
    func toDictionary() -> [String:AnyObject] {
        
        return ["id":self.id as AnyObject, "src":self.src as AnyObject , "imageDescription":self.imageDescription as AnyObject ]
    }
}

extension ProductVariant:JSONConvertible {
    
    convenience init(from productVariantJSON:String?) {
        self.init()
        guard productVariantJSON != nil else {
            return
        }
        do {
            if let productVariantJSONDict = try JSONSerialization.jsonObject(with: productVariantJSON!.data(using: .utf8)!, options: .allowFragments) as? Dictionary<String, Any> {
                
                self.id = productVariantJSONDict["id"] as? String ?? ""
                self.title = productVariantJSONDict["title"] as? String
                if let priceString  = productVariantJSONDict["price"] as? String {
                    
                    self.price = Decimal(string: priceString)
                }
                self.available = productVariantJSONDict["available"] as? Bool ?? false
                self.productId = productVariantJSONDict["productId"] as? String ?? ""
                if let _image = productVariantJSONDict["image"] as? String {
                    
                    let imageData = try JSONSerialization.data(withJSONObject: _image, options: .prettyPrinted)
                    let imageJSONString = String(data: imageData, encoding: .utf8)
                    self.image = Image(from: imageJSONString)
                }
                if let selectedOptionsJSON = productVariantJSONDict["selectedOptions"] as? String{
                    
                    let _selectedOptionsJSONObj = try JSONSerialization.jsonObject(with: selectedOptionsJSON.data(using: .utf8)!, options: .allowFragments)
                    if let selectedOptionsJSONObj = _selectedOptionsJSONObj as? [[String:Any]] {
                        var _selectedOptions = [VariantOption]()
                        for _variantOption in selectedOptionsJSONObj {
                            
                            let variantOptionData = try JSONSerialization.data(withJSONObject: _variantOption, options: .prettyPrinted)
                            let variantOptionJSONString = String(data: variantOptionData, encoding: .utf8)
                            let variantOption = VariantOption(from: variantOptionJSONString)
                            _selectedOptions.append(variantOption)
                        }
                        self.selectedOptions = _selectedOptions
                    }
                }
            }
        }
        catch {
            
            print("Error in converting Product Variant JSON string to a valid JSON object!")
        }
    }
    
    func toDictionary() -> [String : AnyObject] {
        return ["id":self.id as AnyObject, "title":self.title as AnyObject? ?? "" as AnyObject, "price":self.price as AnyObject? ?? "" as AnyObject, "available":self.available as AnyObject, "productId":self.productId as AnyObject, "image":self.image?.toDictionary() as AnyObject, "selectedOptions":VariantOption.toDictionaryArray(source: self.selectedOptions!) as AnyObject]
    }
}

extension OrderItem:JSONConvertible {
    
    func toDictionary() -> [String : AnyObject] {
        
        return ["quantity":self.quantity as AnyObject, "title":self.title as AnyObject? ?? "" as AnyObject, "productVariant":self.productVariant?.toDictionary() as AnyObject]
    }
    
    static func toDictionaryArray(source objectArray:[Any]?) -> [[String:AnyObject]] {
        
        if let sourceArray = objectArray as? [OrderItem] {
            var retArray = [[String:AnyObject]]()
            for orderItem in sourceArray {
                
                let newOrderItem = orderItem.toDictionary()
                retArray.append(newOrderItem)
                
            }
            return retArray
        }
        else {
            
            return [["":"" as AnyObject]]
        }
    }
}

extension Address {

    func toDictionary() -> [String : AnyObject] {
        
        return ["id":self.id as AnyObject, "firstName":self.firstName as AnyObject? ?? "" as AnyObject, "lastName":self.lastName as AnyObject? ?? "" as AnyObject, "address":self.address as AnyObject, "secondAddress":self.secondAddress as AnyObject, "city":self.city as AnyObject, "country":self.country as AnyObject, "state":self.state as AnyObject, "zip":self.zip as AnyObject, "phone":self.phone as AnyObject ]
    }
    
    convenience init(addressJSON:String?) {
        
        self.init()
        guard addressJSON != nil else {
            return
        }
        let addressObj = Address()
        do {
            if let addressJSONDict = try JSONSerialization.jsonObject(with: addressJSON!.data(using: .utf8)!, options: .allowFragments) as? Dictionary<String, String> {
                
                addressObj.firstName = addressJSONDict["firstName"]
                addressObj.lastName = addressJSONDict["lastName"]
                addressObj.address = addressJSONDict["address"]
                addressObj.secondAddress = addressJSONDict["secondAddress"]
                addressObj.city = addressJSONDict["city"]
                addressObj.country = addressJSONDict["country"]
                addressObj.state = addressJSONDict["state"]
                addressObj.zip = addressJSONDict["zip"]
                addressObj.phone = addressJSONDict["phone"]
            }
        }
        catch {
            
            print("Error in converting address JSON string to a valid JSON object!")
            return
        }
    }
    
    static func toDictionaryArray(source objectArray:[Any]?) -> [[String : AnyObject]] {
        
        if let sourceArray = objectArray as? [Address] {
            var retArray = [[String:AnyObject]]()
            for anItem in sourceArray {
                
                let newItem = anItem.toDictionary()
                retArray.append(newItem)
                
            }
            return retArray
        }
        else {
            
            return [["":"" as AnyObject]]
        }
    }
}

extension LineItem :JSONConvertible {
    
    convenience init(from lineItem:String?) {
        self.init()
        guard lineItem != nil else {
            
            return
        }
        do {
            if let addressJSONDict = try JSONSerialization.jsonObject(with: lineItem!.data(using: .utf8)!, options: .allowFragments) as? Dictionary<String, Any> {
                
                self.id = addressJSONDict["id"] as! String
                if let temp = addressJSONDict["price"] as? Int {
                    
                    self.price = Decimal(integerLiteral: temp)
                }
                self.quantity = addressJSONDict["quantity"] as? Int ?? 0
            }
        }
        catch {
            
            print("Error in converting address JSON string to a valid JSON object!")
        }
    }
    
    func toDictionary() -> [String:AnyObject] {
        
        return ["id":self.id as AnyObject, "price":self.price as AnyObject, "quantity":self.quantity as AnyObject]
    }
    
    static func toDictionaryArray(source objectArray:[Any]?) -> [[String : AnyObject]] {
        
        if let sourceArray = objectArray as? [LineItem] {
            var retArray = [[String:AnyObject]]()
            for anItem in sourceArray {
                
                let newItem = anItem.toDictionary()
                retArray.append(newItem)
                
            }
            return retArray
        }
        else {
            
            return [["":"" as AnyObject]]
        }
    }
}

extension CartProduct {
    
    convenience init(from cartProductJSON:String?) {
        self.init()
        guard cartProductJSON != nil else {
            return
        }
        do {
            if let cartProductJSONDict = try JSONSerialization.jsonObject(with: cartProductJSON!.data(using: .utf8)!, options: .allowFragments) as? Dictionary<String, Any> {
                
                self.productId = cartProductJSONDict["productId"] as? String
                self.productTitle = cartProductJSONDict["productTitle"] as? String
                self.currency = cartProductJSONDict["currency"] as? String
                self.quantity = cartProductJSONDict["quantity"] as? Int ?? 0
                if let _productVariant = cartProductJSONDict["productVariant"] as? [String:Any] {
                    
                    let productVariantData = try JSONSerialization.data(withJSONObject: _productVariant, options: .prettyPrinted)
                    let productVariantJSONString = String(data: productVariantData, encoding: .utf8)
                    self.productVariant = ProductVariant(from: productVariantJSONString)
                }
            }
        }
        catch {
            
            print("Error in converting Product Variant JSON string to a valid JSON object!")
        }
    }
    
    func toDictionary() -> [String : AnyObject] {
        
        return ["productId":self.productId as AnyObject, "productTitle":self.productTitle as AnyObject? ?? "" as AnyObject, "currency":self.currency as AnyObject? ?? "" as AnyObject, "quantity":self.quantity as AnyObject, "productVariant":self.productVariant?.toDictionary() as AnyObject]
    }
}

extension PayAddress {
    
    //Address object does not contain email and hence this has to be separately brought in!
    init(from addressObj:Address, email:String?) {
        self.init(addressLine1: addressObj.address, addressLine2: addressObj.secondAddress, city: addressObj.city, country: addressObj.country, province: addressObj.state, zip: addressObj.zip, firstName: addressObj.firstName, lastName: addressObj.lastName, phone: addressObj.phone, email: email)
    }
}

extension Order:JSONConvertible {
    
    func toDictionary() -> [String : AnyObject] {
        return ["id":self.id as AnyObject, "firs":self.currencyCode as AnyObject? ?? "" as AnyObject, "number":self.number as AnyObject? ?? "" as AnyObject, "createdAt":self.createdAt as AnyObject, "shippingAddress":self.shippingAddress?.toDictionary() as AnyObject, "subtotalPrice":self.subtotalPrice as AnyObject, "totalPrice":self.totalPrice as AnyObject, "totalShippingPrice":self.totalShippingPrice as AnyObject, "paginationValue":self.paginationValue as AnyObject, "items":OrderItem.toDictionaryArray(source: self.items) as AnyObject]
    }
}

extension Customer:JSONConvertible {
    
    func toDictionary() -> [String : AnyObject] {
        return ["email":self.email as AnyObject, "firstName":self.firstName as AnyObject? ?? "" as AnyObject, "lastName":self.lastName as AnyObject? ?? "" as AnyObject, "phone":self.phone as AnyObject, "promo":self.promo as AnyObject, "defaultAddress":self.defaultAddress?.toDictionary() as AnyObject, "addresses":Address.toDictionaryArray(source: self.addresses) as AnyObject]
    }
}

