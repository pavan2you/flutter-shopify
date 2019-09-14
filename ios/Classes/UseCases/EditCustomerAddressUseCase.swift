//
//  EditCustomerAddressUseCase.swift
//  shopify
//
//  Created by Joseph jose on 10/09/19.
//

import UIKit
import ShopApp_Shopify
import ShopApp_Gateway
import Flutter

class EditCustomerAddressUseCase: UseCase {

    static let ARG_ADDRESS_ID = "addressId"
    static let ARG_PRIMARY_ADDRESS = "primaryAddress"
    static let ARG_SECOND_ADDRESS = "secondAddress"
    static let ARG_CITY = "city"
    static let ARG_STATE = "state"
    static let ARG_COUNTRY = "country"
    static let ARG_ZIP = "zip"
    static let ARG_FIRST_NAME = "firstName"
    static let ARG_LAST_NAME = "lastName"
    static let ARG_COMPANY = "company"
    static let ARG_PHONE = "phone"
    
    override public init(_ context: PluginContext) {
        super.init(context)
    }
    
    override public func trigger(with methodCall: FlutterMethodCall, result: @escaping (Any?) -> Void) {
        
        if let args = methodCall.arguments as? [String:String] {
            let id = args[EditCustomerAddressUseCase.ARG_ADDRESS_ID]
            let primaryAddress = args[EditCustomerAddressUseCase.ARG_PRIMARY_ADDRESS]
            let secondAddress = args[EditCustomerAddressUseCase.ARG_SECOND_ADDRESS]
            let city = args[EditCustomerAddressUseCase.ARG_CITY]
            let state = args[EditCustomerAddressUseCase.ARG_STATE]
            let country = args[EditCustomerAddressUseCase.ARG_COUNTRY]
            let firstName = args[EditCustomerAddressUseCase.ARG_FIRST_NAME]
            let lastName = args[EditCustomerAddressUseCase.ARG_LAST_NAME]
            let zip = args[EditCustomerAddressUseCase.ARG_ZIP]
            let company = args[EditCustomerAddressUseCase.ARG_COMPANY]
            let phone = args[EditCustomerAddressUseCase.ARG_PHONE]
            
            let address = Address()
            address.firstName = firstName
            address.lastName = lastName
            address.address = primaryAddress
            address.secondAddress = secondAddress
            address.city = city
            address.state = state
            address.country = country
            address.zip = zip
            address.phone = phone
            address.id = id ?? ""
            
            (mContext.api.instance as! ShopifyAPI).updateCustomerAddress(with: address) { (success, error) in
                
                if error != nil {
                    
                    self.createError(withCase: "EditCustomerAddressUseCase", message: error!.errorMessage, error: error!, on: result)
                }else {
                    
                    result(success)
                }
            }
            
        }
    }
    
}
