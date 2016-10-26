//
//  LoginRouter.swift
//  Redmine
//
//  Created by David Martinez on 19/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class LoginRouter: NSObject, LoginRouterInterface {

    private var originController : UIViewController!
    private let segueSignUp = "login_to_signup"
    private let segueProjects = "login_to_projectlist"
    
    func navigateToSignUp() {
        originController.performSegue(withIdentifier: segueSignUp, sender: nil)
    }
    
    func navigateToProjects(account: Account) {
        originController.performSegue(withIdentifier: segueProjects, sender: nil)
    }
    
    required init(controller: UIViewController) {
        originController = controller
    }
}
