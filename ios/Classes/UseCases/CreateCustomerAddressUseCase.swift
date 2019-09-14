//
//  CreateCustomerAddressUseCase.swift
//  shopify
//
//  Created by Joseph jose on 10/09/19.
//

import UIKit
import ShopApp_Shopify
import ShopApp_Gateway
import Flutter

class CreateCustomerAddressUseCase: UseCase {

    static let ARG_ADDRESS_JSON = "addressJson"
    
    override public init(_ context: PluginContext) {
        super.init(context)
    }
    
    override public func trigger(with methodCall: FlutterMethodCall, result: @escaping (Any?) -> Void) {
        
        if let args = methodCall.arguments as? [String:String] {
            if let addressJson = args[CreateCustomerAddressUseCase.ARG_ADDRESS_JSON] {
                
                let addr = Address(addressJSON: addressJson)
                (mContext.api.instance as! ShopifyAPI).addCustomerAddress(with: addr) { (addressId, error) in
                    
                    if error == nil && addressId != nil {
                        
                        result(addressId)
                    }else if addressId == nil {
                        
                        result(false)
                    }else {
                        
                        self.createError(withCase: "createCustomerAddressUseCase", message: error!.errorMessage, error: error!, on: result)
                    }
                }
            }
        }
    }
}
