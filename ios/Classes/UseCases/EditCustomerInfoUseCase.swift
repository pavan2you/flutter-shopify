//
//  EditCustomerInfoUseCase.swift
//  shopify
//
//  Created by Joseph jose on 10/09/19.
//

import UIKit
import ShopApp_Shopify
import ShopApp_Gateway
import Flutter

class EditCustomerInfoUseCase: UseCase {

    static let ARG_FIRST_NAME = "firstName"
    static let ARG_LAST_NAME = "lastName"
    static let ARG_PHONE = "phone"
    static let ARG_EMAIL = "email"
    
    override public init(_ context: PluginContext) {
        super.init(context)
    }
    
    override public func trigger(with methodCall: FlutterMethodCall, result: @escaping (Any?) -> Void) {
        
        if let args = methodCall.arguments as? [String:String] {

            let firstName = args[EditCustomerInfoUseCase.ARG_FIRST_NAME]
            let lastName = args[EditCustomerInfoUseCase.ARG_LAST_NAME]
            let email = args[EditCustomerInfoUseCase.ARG_EMAIL]
            let phone = args[EditCustomerInfoUseCase.ARG_PHONE]
            
            (mContext.api.instance as! ShopifyAPI).updateCustomer(with: email!, firstName: firstName, lastName: lastName, phone: phone) { (customer, error) in
                
                if error != nil {
                    
                    self.createError(withCase: "EditCustomerInfoUseCase", message: error!.errorMessage, error: error!, on: result)
                }else {
                    
                    let customerJSONObj = customer!.toDictionary()
                    do {
                        
                        let customerJSON = try JSONSerialization.data(withJSONObject: customerJSONObj, options: .prettyPrinted)
                        let customerJsonString = String(data: customerJSON, encoding: .utf8)
                        result(customerJsonString)
                    }
                    catch {
                        
                        self.createError(withCase: "EditCustomerInfoUseCase", message: error.localizedDescription, error: error, on: result)
                    }
                }
            }
        }
    }
}
