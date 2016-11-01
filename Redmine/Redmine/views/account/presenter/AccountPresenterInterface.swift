//
//  AccountPresenterInterface.swift
//  Redmine
//
//  Created by David Martinez on 29/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

protocol AccountPresenterInterface : NSObjectProtocol {

    func bind (view : AccountLayoutInterface)
    func loadAccounts ()
    func removeAccount (_ account : Account)
    func selectAccount (_ account : Account)
    
}
