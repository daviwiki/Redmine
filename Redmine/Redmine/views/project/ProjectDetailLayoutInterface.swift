//
//  ProjectDetailLayoutInterface.swift
//  Redmine
//
//  Created by David Martinez on 10/11/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

protocol ProjectDetailLayoutInterface : NSObjectProtocol {

    func setAccount (account : Account)
    func setProject (project : Project)
    
    func showLoading ()
    func showIssuesInfo (_ issues : [Issue])
    func showError (_ message : String)
    
}
