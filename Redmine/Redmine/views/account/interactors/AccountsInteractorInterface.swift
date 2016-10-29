//
//  GetAccountsInterfactorInterface.swift
//  Redmine
//
//  Created by David Martinez on 29/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

protocol AccountsInteractorInterface : NSObjectProtocol {

    func getAccounts (_ callback: @escaping ([Account]) -> Void)
    func removeAccount (_ account: Account, _ callback: @escaping (_ account: Account, _ removed: Bool) -> Void)
    
}
