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
    
    func selectAccount(_ account: Account) {
        account.isSelected = true
        interactor.selectAccount(account, { [weak self] (account : Account) in
            self?.interactor.getAccounts({ (accounts : [Account]) in
                self?.view?.showAccounts(accounts)
            })
        })
    }
    
    func removeAccount(_ account: Account) {
        interactor.removeAccount(account) { [weak self] (account: Account, removed: Bool) in
            self?.view?.removeAccount(account)
            
            if (account.isSelected) {
                self?.interactor.getAccounts({ [weak self] (accounts : [Account]) in
                    guard let ac = accounts.first else { return }
                    ac.isSelected = true
                    self?.interactor.selectAccount(ac, { (ac : Account) in
                        self?.view?.refreshAccount(ac)
                    })
                })
            }
        }
    }
    
    override init() {
        super.init()
        interactor = AccountFactory.getInstance().getAccountsInterator()
    }
}
