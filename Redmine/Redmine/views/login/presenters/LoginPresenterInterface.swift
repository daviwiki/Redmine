//
//  LoginPresenterInterface.swift
//  Redmine
//
//  Created by David Martinez on 18/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

protocol LoginPresenterInterface {
    
    func bind (_ view : LoginLayoutInterface)
    func unbind (_ view : LoginLayoutInterface)
    func onViewAppear ()
    func onLogin(account: Account)
    func onCreateAccount ()
    func onManageAccounts ()
    
}
