//
//  ProjectListRouterInterface.swift
//  Redmine
//
//  Created by David Martinez on 24/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

protocol ProjectListRouterInterface: NSObjectProtocol {

    func navigateToProject (_ project : Project)
    
    init(controller: UIViewController)
    
}
