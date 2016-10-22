//
//  SingUpPresenter.swift
//  Redmine
//
//  Created by David Martinez on 1/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class SignUpPresenter: NSObject, SignUpPresenterInterface {
    
    // MARK: Services
    func configureViewForPresentation(view : SignUpLayoutInterface) {
        
    }
    
    func onCreateAccount(view : SignUpLayoutInterface, name: String?, host: String?, token: String?) {
        
        let interactor = SignUpFactory.getSignUpCreateAccount()
        let router = SignUpFactory.getSignUpRouter()
        
        interactor.createAccount(
            name: name, host: host, token: token,
            callback: { (isValid : Bool, message : String?) in
                if (isValid) {
                    router.navigateBack()
                } else {
                    view.showError(message: message!)
                }
            }
        )
    }
    
}
