//
//  SingUpPresenter.swift
//  Redmine
//
//  Created by David Martinez on 1/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

protocol SignUpPresenterInterface : class {
    
    func configureViewForPresentation (view : SignUpLayoutInterface)
    func onCreateAccount (view : SignUpLayoutInterface, name : String?, host : String?, token : String?)
    
    init(interactor : SignUpInteractorInterface, router : SignUpRouterInterface)
}

class SignUpPresenter: NSObject, SignUpPresenterInterface {
    
    var interactor : SignUpInteractorInterface!
    var router : SignUpRouterInterface!
    let localizableFileName = "SignUp"
    
    // MARK: Services
    required init(interactor: SignUpInteractorInterface, router: SignUpRouterInterface) {
        self.interactor = interactor
        self.router = router
    }
    
    func configureViewForPresentation(view : SignUpLayoutInterface) {
        var message : String!
        
        message = getLocalizable(fromId: "account_window_title")
        view.showWindowTitle(title: message)
        
        message = getLocalizable(fromId: "account_name_placeholder")
        view.showNamePlaceholder(name: message)
        
        message = getLocalizable(fromId: "account_host_placeholder")
        view.showHostPlaceholder(name: message)
        
        message = getLocalizable(fromId: "account_token_placeholder")
        view.showTokenPlaceholder(name: message)
        
        message = getLocalizable(fromId: "account_singup_button_name")
        view.showSignUpButtonName(name: message)
    }
    
    func onCreateAccount(view : SignUpLayoutInterface, name: String?, host: String?, token: String?) {
        
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
    
    // MARK: Private
    private func getLocalizable (fromId id : String) -> String? {
        return NSLocalizedString(id, tableName: localizableFileName, bundle: Bundle.main, value: "", comment: "")
    }
}
