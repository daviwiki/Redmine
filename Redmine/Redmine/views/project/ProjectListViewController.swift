//
//  ATEProjectListViewController.swift
//  Redmine
//
//  Created by David Martinez on 22/9/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class ProjectListViewController: UIViewController, ProjectListLayoutInterface {

    private var account : Account!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: ProjectListInterface
    func setAccount(account: Account) {
        self.account = account
    }
    
    func showNoProjects() {
        
    }
    
    func showLatestProjects(_ projects: [Project]) {
        
    }
    
    func showAllProjects(_ projects: [Project]) {
        
    }
}
