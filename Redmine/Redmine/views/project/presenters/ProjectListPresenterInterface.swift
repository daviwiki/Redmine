//
//  ProjectListPresenterInterface.swift
//  Redmine
//
//  Created by David Martinez on 24/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

protocol ProjectListPresenterInterface : NSObjectProtocol {
    
    func bind (_ view: ProjectListLayoutInterface)
    func unbind (_ view: ProjectListLayoutInterface)
    
    func loadProjects (_ account : Account)
    func loadNextProjects (_ account : Account)
    func refreshProjects (_ account : Account)
    
}
