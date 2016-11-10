//
//  ProjectListLayoutInterface.swift
//  Redmine
//
//  Created by David Martinez on 24/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

protocol ProjectListLayoutInterface : NSObjectProtocol {
    
    func setAccount (account : Account)
    func showLoading()
    func showNoProjects()
    func showLatestProjects(_ projects : [Project])
    func showAllProjects(_ projects : [Project])
    
}
