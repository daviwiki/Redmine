//
//  ATEProjectDetailViewController.swift
//  Redmine
//
//  Created by David Martinez on 22/9/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class ProjectDetailViewController: UIViewController, ProjectDetailLayoutInterface {
    
    private var account : Account!
    private var project : Project!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: ProjectDetailLayoutInterface
    func setAccount(account: Account) {
        self.account = account
    }
    
    func setProject(project: Project) {
        self.project = project
    }
    
    func showLoading () {
        
    }
    
    func showIssuesInfo (_ issues : [Issue]) {
        
    }
    
    func showError (_ message : String) {
        
    }
}
