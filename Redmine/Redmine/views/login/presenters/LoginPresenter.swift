//
//  LoginPresenter.swift
//  Redmine
//
//  Created by David Martinez on 19/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class LoginPresenter: NSObject, LoginPresenterInterface {

    private weak var view : LoginLayoutInterface?
    private var router : LoginRouterInterface?
    private var getLoginInteractor : LoginCheckInteractorInterface!
    private var readAccountsInteractor : LoginReadAccountsInterface!
    
    func bind(view: LoginLayoutInterface) {
        self.view = view
    }
    
    func onViewAppear() {
        readAccountsInteractor.readSelectedAccount { [weak self] (account : Account?) in
            if (account == nil) {
                self?.view?.showNoAccount()
            } else {
                self?.view?.showAccount(account: account!)
            }
        }
    }
    
    func onLogin(account: Account) {
        // TODO: Localize string
        // TODO: Improve error message for each error type
        let localizedError = "Couldn't connect with your user"
        do {
            try getLoginInteractor.loginCheck(account) { [weak self] (ok : Bool) in
                if (ok) {
                    self?.router?.navigateToProjects(account: account)
                } else {
                    
                    self?.view?.showError(message: localizedError)
                }
            }
        } catch {
            print (error)
            view?.showError(message: localizedError)
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
