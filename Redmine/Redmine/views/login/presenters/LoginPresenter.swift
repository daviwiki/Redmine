//
//  LoginPresenter.swift
//  Redmine
//
//  Created by David Martinez on 19/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class LoginPresenter: NSObject, LoginPresenterInterface {

    private var router : LoginRouterInterface?
    private var getLoginInteractor : LoginCheckInteractorInterface!
    
    func configureViewForPresentation(view: LoginLayoutInterface) {
        // TODO:
    }
    
    func onLogin(account: Account) {
        router?.navigateToProjects()
    }
    
    func onCreateAccount() {
        router?.navigateToSignUp()
    }
    
    init(factory : LoginFactory) {
        do {
            router = try factory.getRouter()
        } catch {
            print(error)
        }
        
        getLoginInteractor = factory.getCheckSyncInteractor()
    }
    
}
