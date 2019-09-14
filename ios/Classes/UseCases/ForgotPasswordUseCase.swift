//
//  ForgotPasswordUseCase.swift
//  shopify
//
//  Created by Joseph jose on 10/09/19.
//

import UIKit
import ShopApp_Shopify
import ShopApp_Gateway
import Flutter

class ForgotPasswordUseCase: UseCase {

    static let ARG_EMAIL = "email"
    
    override public init(_ context: PluginContext) {
        super.init(context)
    }
    
    override public func trigger(with methodCall: FlutterMethodCall, result: @escaping (Any?) -> Void) {
        
        if let args = methodCall.arguments as? [String:String] {
            
            let email = args[ForgotPasswordUseCase.ARG_EMAIL]
            
            (mContext.api.instance as! ShopifyAPI).resetPassword(with: email!) { (success, error) in
                
                if error != nil {
                    
                    self.createError(withCase: "ForgotPasswordUseCase", message: error!.errorMessage, error: error!, on: result)
                }else {
                    
                    result(success)
                }
            }
        }
    }
}
