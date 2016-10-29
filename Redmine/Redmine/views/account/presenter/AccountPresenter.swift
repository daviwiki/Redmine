//
//  AccountPresenter.swift
//  Redmine
//
//  Created by David Martinez on 29/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class AccountPresenter: NSObject, AccountPresenterInterface {

    private weak var view : AccountLayoutInterface?
    private var interactor : AccountsInteractorInterface!
    
    func bind(view: AccountLayoutInterface) {
        self.view = view
    }
    
    func loadAccounts() {
        interactor.getAccounts { [weak self] (accounts: [Account]) in
            self?.view?.showAccounts(accounts)
        }
    }
    
    func removeAccount(_ account: Account) {
        interactor.removeAccount(account) { [weak self] (account: Account, removed: Bool) in
            self?.view?.removeAccount(account)
        }
    }
    
    override init() {
        super.init()
        interactor = AccountFactory.getInstance().getAccountsInterator()
    }
}
