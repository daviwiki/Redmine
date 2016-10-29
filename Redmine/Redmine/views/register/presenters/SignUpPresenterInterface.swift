//
//  SignUpPresenterInterface.swift
//  Redmine
//
//  Created by David Martinez on 18/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

protocol SignUpPresenterInterface : class {
    
    func bind (view : SignUpLayoutInterface)
    func createAccount (name : String?, host : String?, token : String?)
    
}
