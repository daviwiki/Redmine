//
//  AccountStorage.swift
//  Redmine
//
//  Created by David Martinez on 28/9/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

protocol AccountStorage {
    
    func getAccounts () -> [Account]
    func saveAccount (account : Account)
    func removeAccount (account : Account)
    
}
