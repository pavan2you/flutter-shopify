//
//  CreateCheckoutUseCase.swift
//  shopify
//
//  Created by Joseph jose on 17/08/19.
//

import UIKit
import ShopApp_Shopify
import ShopApp_Gateway
import Flutter

public class CreateCheckoutUseCase: UseCase {

    static let ARG_CART_PRODUCT_JSON = "cartProductJson"
    
    override public init(_ context: PluginContext) {
        super.init(context)
    }
    
    override public func trigger(with methodCall: FlutterMethodCall, result: @escaping (Any?) -> Void) {
        
        if let args = methodCall.arguments as? [String:String] {
            if let cartProductJson = args[CreateCheckoutUseCase.ARG_CART_PRODUCT_JSON] as? String {
                
                do {
                    let _cartProductJSONObj = try JSONSerialization.jsonObject(with: cartProductJson.data(using: .utf8)!, options: .allowFragments)
                    if let cartProductJSONObj = _cartProductJSONObj as? [[String:Any]] {
                        var cartProducts = [CartProduct]()
                        for cartProductObj in cartProductJSONObj {
                            
                            let cartProductData = try JSONSerialization.data(withJSONObject: cartProductObj, options: .prettyPrinted)
                            let cartProductJSONString = String(data: cartProductData, encoding: .utf8)
                            let cartProduct = CartProduct(from: cartProductJSONString)
                            cartProducts.append(cartProduct)
                        }
                        
                        (mContext.api.instance as! ShopifyAPI).createCheckout(cartProducts: cartProducts) { (checkout, error) in
                            
                            if checkout != nil {
                                
                                let checkoutJSONObject = checkout!.toDictionary()
                                do {
                                    let jsonResponse = try JSONSerialization.data(withJSONObject: checkoutJSONObject, options: .prettyPrinted)
                                    let orderJsonString = String(data: jsonResponse, encoding: .utf8)
                                    result(orderJsonString)
                                }
                                catch {
                                    
                                    print("Error in creating JSON object from cehckout response!")
                                    self.createError(withCase: "createCheckoutUseCase", message: error.localizedDescription , error: error, on: result)
                                }
                                
                            }else if error != nil {
                                
                                self.createError(withCase: "createCheckoutUseCase", message: error!.errorMessage ?? "", error: error!, on: result)
                            }else {
                                
                                result(false)
                            }
                        }
                    }
                }
                catch {
                    
                    print("Error in creating cart procucts from JSON Data!")
                    result(false)
                }
            }
        }
    }
}
