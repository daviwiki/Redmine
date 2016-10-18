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
        return SignUpPresenter(interactor: getSignUpInteractor(), router: getSignUpRouter())
    }
    
    static func getSignUpInteractor () -> SignUpInteractorInterface {
        return SignUpInteractor()
    }
    
    static func getSignUpRouter () -> SignUpRouterInterface {
        return SignUpRouter()
    }
    
    static func getSignUpAccountStorage () -> AccountStorageInterface {
        return CoreDataModelManager.getInstance().getAccountStorageManager()
    }
}
