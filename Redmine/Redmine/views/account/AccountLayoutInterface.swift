//
//  AccountLayoutInterface.swift
//  Redmine
//
//  Created by David Martinez on 29/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

protocol AccountLayoutInterface: NSObjectProtocol {

    func showAccounts (_ accounts : [Account])
    func refreshAccount (_ account : Account)
    func removeAccount (_ account : Account)
    
}
