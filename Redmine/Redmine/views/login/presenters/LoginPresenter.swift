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
    
    // MARK: Lifecycle
    override init() {
        super.init()
    }
    
    func setLoginInteractor (_ loginInteractor : LoginCheckInteractorInterface) {
        getLoginInteractor = loginInteractor
    }
    
    func setReadAccountInteractor (_ readAccountInteractor : LoginReadAccountsInterface) {
        self.readAccountsInteractor = readAccountInteractor
    }
    
    func setRouter (_ router : LoginRouterInterface) {
        self.router = router
    }
    
    // MARK: LoginPresenterInterface
    func bind(_ view: LoginLayoutInterface) {
        self.view = view
    }
    
    func unbind(_ view: LoginLayoutInterface) {
        self.view = nil
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
        view?.showLoading()
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
    
}
