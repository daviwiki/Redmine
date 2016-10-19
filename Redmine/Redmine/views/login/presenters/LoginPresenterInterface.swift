//
//  LoginPresenterInterface.swift
//  Redmine
//
//  Created by David Martinez on 18/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

protocol LoginPresenterInterface {
    
    func configureViewForPresentation (view : LoginLayoutInterface)
    func onViewAppear (view : LoginLayoutInterface)
    func onLogin (account : Account)
    func onCreateAccount ()
    
}
