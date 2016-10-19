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
    private var readAccountsInteractor : LoginReadAccountsInterface!
    
    func configureViewForPresentation(view: LoginLayoutInterface) {
        // TODO: Localization and start
    }
    
    func onViewAppear(view: LoginLayoutInterface) {
        readAccountsInteractor.readAccounts { (accounts : [Account]) in
            if (accounts.count == 0) {
                view.showNoAccount()
            } else {
                view.showAccount(account: accounts.first!)
            }
        }
    }
    
    func onLogin(account: Account) {
        router?.navigateToProjects()
    }
    
    func onCreateAccount() {
        router?.navigateToSignUp()
    }
    
    override init() {
        
        let factory = LoginFactory.getInstance()
        do {
            router = try factory.getRouter()
        } catch {
            print(error)
        }
        
        getLoginInteractor = factory.getCheckSyncInteractor()
        readAccountsInteractor = factory.getReadAccountInteractor()
    }
    
}
