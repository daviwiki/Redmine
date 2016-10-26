//
//  LoginRouterInterface.swift
//  Redmine
//
//  Created by David Martinez on 18/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

protocol LoginRouterInterface {
    
    func navigateToSignUp ()
    func navigateToProjects (account: Account)
    
    init (controller : UIViewController)
}
