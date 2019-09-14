//
//  DeleteCustomerAddressUseCase.swift
//  shopify
//
//  Created by Joseph jose on 10/09/19.
//

import UIKit
import ShopApp_Shopify
import ShopApp_Gateway
import Flutter

class DeleteCustomerAddressUseCase: UseCase {

    static let ARG_ADDRESS_ID = "addressId"
    
    override public init(_ context: PluginContext) {
        super.init(context)
    }
    
    override public func trigger(with methodCall: FlutterMethodCall, result: @escaping (Any?) -> Void) {
        
        if let args = methodCall.arguments as? [String:String] {
            if let addressId = args[DeleteCustomerAddressUseCase.ARG_ADDRESS_ID] {
                
                (mContext.api.instance as! ShopifyAPI).deleteCustomerAddress(with: addressId) { (success, error) in
                    if error != nil {
                        
                        self.createError(withCase: "DeleteCustomerAddressUseCase", message: error!.errorMessage, error: error!, on: result)
                    }else {
                        
                        result(success)
                    }
                }
            }
        }
    }
}
