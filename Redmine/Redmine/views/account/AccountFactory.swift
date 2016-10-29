//
//  AccountFactory.swift
//  Redmine
//
//  Created by David Martinez on 29/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class AccountFactory: NSObject {

    private static let instance = AccountFactory()
    
    static func getInstance() -> AccountFactory {
        return instance
    }
    
    func getPresenter () -> AccountPresenterInterface {
        return AccountPresenter()
    }
    
    func getAccountsInterator () -> AccountsInteractorInterface {
        return AccountsInteractor()
    }
    
    func getAccountStorage (_ callback : @escaping (AccountStorageInterface) -> Void) {
        AccountStorageCoreDataFactory.getInstance().getAccountStorageManager(callback)
    }
}
