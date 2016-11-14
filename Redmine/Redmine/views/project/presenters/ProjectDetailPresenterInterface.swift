//
//  ProjectDetailPresenterInterface.swift
//  Redmine
//
//  Created by David Martinez on 14/11/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

protocol ProjectDetailPresenterInterface : NSObjectProtocol {
    
    func bind (_ view : ProjectDetailLayoutInterface)
    func unbind ()
    
    func loadIssues (_ account : Account, _ project : Project!)
    func loadNextIssues (_ account : Account, _ project : Project)
    func refreshIssues (_ account : Account, _ project : Project)
    
}
