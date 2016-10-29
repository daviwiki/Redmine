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
        // do nothing
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
    
    func onLogin(account: Account, view: LoginLayoutInterface) {
        // TODO: Localize string
        // TODO: Improve error message for each error type
        let localizedError = "Couldn't connect with your user"
        do {
            try getLoginInteractor.loginCheck(account) { [weak self] (ok : Bool) in
                if (ok) {
                    self?.router?.navigateToProjects(account: account)
                } else {
                    
                    view.showError(message: localizedError)
                }
            }
        } catch {
            print (error)
            view.showError(message: localizedError)
        }
    }
    
    func onCreateAccount() {
        router?.navigateToSignUp()
    }
    
    func onManageAccounts() {
        router?.navigateToManageAccounts()
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
