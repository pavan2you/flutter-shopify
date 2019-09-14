//
//  ChangePasswordUseCase.swift
//  shopify
//
//  Created by Joseph jose on 17/08/19.
//

import UIKit
import ShopApp_Shopify
import Flutter

public class ChangePasswordUseCase: UseCase {
    
    static let ARG_PASSWORD = "password"
    
    override public init(_ context:PluginContext) {
        super.init(context)
    }
    
    override public func trigger(with methodCall: FlutterMethodCall, result: @escaping (Any?) -> Void) {
        
        if let args = methodCall.arguments as? [String:String] {
            
            if let password = args[ChangePasswordUseCase.ARG_PASSWORD] {
                
                (mContext.api.instance as! ShopifyAPI).updateCustomer(with: password, callback: { (customer, error) in
                    
                    if error != nil {
                        
                        self.createError(withCase: "ChangePasswordUseCase", message: error!.errorMessage, error: error!, on: result)
                    }else {
                        
                        if customer != nil {
                            result(true)
                        }else {
                            
                            result(false)
                        }
                    }
                })
            }
        }
    }
}

