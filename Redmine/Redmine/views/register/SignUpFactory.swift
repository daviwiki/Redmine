//
//  SignUpFactory.swift
//  Redmine
//
//  Created by David Martinez on 18/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class SignUpFactory: NSObject {

    private static let instance = SignUpFactory()
    
    static func getInstance() -> SignUpFactory {
        return instance
    }
    
    func getSignUpPresenter () -> SignUpPresenterInterface {
        return SignUpPresenter()
    }
    
    func getSignUpCreateAccount () -> SignUpCreateAccountInterface {
        return SignUpCreateAccount()
    }
    
    func getSignUpRouter () -> SignUpRouterInterface {
        return SignUpRouter()
    }
    
    func getSignUpAccountStorage (_ callback : @escaping (AccountStorageInterface) -> Void) {
        AccountStorageCoreDataFactory.getInstance().getAccountStorageManager(callback)
    }
}
