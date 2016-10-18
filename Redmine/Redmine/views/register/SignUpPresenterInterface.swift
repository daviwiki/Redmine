//
//  SignUpPresenterInterface.swift
//  Redmine
//
//  Created by David Martinez on 18/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

protocol SignUpPresenterInterface : class {
    
    func configureViewForPresentation (view : SignUpLayoutInterface)
    func onCreateAccount (view : SignUpLayoutInterface, name : String?, host : String?, token : String?)
    
    init(interactor : SignUpInteractorInterface, router : SignUpRouterInterface)
}
