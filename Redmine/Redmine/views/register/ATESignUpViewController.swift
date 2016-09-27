//
//  ATESignUpViewController.swift
//  Redmine
//
//  Created by David Martinez on 26/9/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class ATESignUpViewController: UIViewController {

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: View
    private func configureView () {
        
    }
    
    // MARK: Presenters - Interactor
    private func accountExists (name : String) -> Bool {
        return true
    }
    
    private func storeAccount (name : String, host : String, key : String) {
        
    }
    
    private func persistAccount (name : String, host : String, key : String) {
        
    }
    
    // MARK: Storage
    private func storeAccount (account : ATEAccount ) {
        
    }
}
