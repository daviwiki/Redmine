//
//  SignUpInteractorInterface.swift
//  Redmine
//
//  Created by David Martinez on 18/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

protocol SignUpInteractorInterface : NSObjectProtocol {
    
    /**
     Try to store the account for the information given.
     - Parameters:
     name, account name
     host, account host (must be absolute url)
     token, account token
     callback,
     - Important:
     You must check if the account information is valid before call this
     method using isValidAccountInfo located in this class
     */
    func createAccount (
        name : String?, host : String?, token: String?,
        callback: (_ isValid: Bool, _ errorMessage: String?) -> Void)
    
}
