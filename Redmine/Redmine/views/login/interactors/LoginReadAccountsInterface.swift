//
//  LoginReadAccountsInterface.swift
//  Redmine
//
//  Created by David Martinez on 19/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

protocol LoginReadAccountsInterface {
    
    func readAccounts (callback : @escaping ([Account]) -> ())
    
}
