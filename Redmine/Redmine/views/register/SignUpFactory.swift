//
//  SignUpFactory.swift
//  Redmine
//
//  Created by David Martinez on 18/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class SignUpFactory: NSObject {

    static func getSignUpPresenter () -> SignUpPresenterInterface {
        return SignUpPresenter()
    }
    
    static func getSignUpCreateAccount () -> SignUpCreateAccountInterface {
        return SignUpCreateAccount()
    }
    
    static func getSignUpRouter () -> SignUpRouterInterface {
        return SignUpRouter()
    }
    
    static func getSignUpAccountStorage (_ callback : @escaping (AccountStorageInterface) -> Void) {
        CoreDataModelManager.getInstance().getAccountStorageManager(callback)
    }
}
