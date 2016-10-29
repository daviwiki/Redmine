//
//  SignUpLayoutInterface.swift
//  Redmine
//
//  Created by David Martinez on 1/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

protocol SignUpLayoutInterface : NSObjectProtocol {

    func showError (message : String)
    func showAccountCreated (account : Account)
    
}
