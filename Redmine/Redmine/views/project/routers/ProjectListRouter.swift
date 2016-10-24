//
//  ProjectListRouter.swift
//  Redmine
//
//  Created by David Martinez on 24/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class ProjectListRouter: NSObject, ProjectListRouterInterface {

    private weak var originController : UIViewController?
    
    func navigateToProject(_ project: ProjectInterface) {
        // TODO: 
    }
    
    required init(controller: UIViewController) {
        originController = controller
    }
    
}
