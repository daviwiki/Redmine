//
//  SingUpPresenter.swift
//  Redmine
//
//  Created by David Martinez on 1/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class SignUpPresenter: NSObject, SignUpPresenterInterface {
    
    private weak var view : SignUpLayoutInterface?
    
    // MARK: Services
    func bind(view: SignUpLayoutInterface) {
        self.view = view
    }
    
    func createAccount (name: String?, host: String?, token: String?) {
        
        let interactor = SignUpFactory.getInstance().getSignUpCreateAccount()
        let router = SignUpFactory.getInstance().getSignUpRouter()
        
        interactor.createAccount(
            name: name, host: host, token: token,
            callback: { [weak self] (isValid : Bool, message : String?) in
                if (isValid) {
                    router.navigateBack()
                } else {
                    self?.view?.showError(message: message!)
                }
            }
        )
    }
    
}
