//
//  ATELoginViewController.swift
//  Redmine
//
//  Created by David Martinez on 22/9/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class ATELoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField : UITextField!
    @IBOutlet weak var passwordTextField : UITextField!
    
    var account : ATEAccount?
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Actions
    @IBAction func actionLogin (sender : AnyObject) {
        if account != nil {
            checkAccountBeforeNavigate(account: account!, callback: { (loginOk : Bool) in
                navigateToProjectList()
            })
        }
    }
    
    @IBAction func actionSingUp (sender : AnyObject) {
        navigateToSignUp()
    }
    
    @IBAction func actionDisplayAccounts (sender : AnyObject) {
        // TODO: Display user accounts (for multiple account management. Not available at this time)
    }
    
    // MARK: View (Errors)
    private func showLoginError (errorType type : ATELoginErrorType) {
        // TODO: Implementar
    }
    
    // MARK: Presenter ()
    private func checkAccountBeforeNavigate (account : ATEAccount, callback : (Bool) -> ()) {
        // TODO: At today we don't check that the data introduce by the user is
        // ok. At future, system will call to project list at this point, if service
        // returns a 403, then the account will be invalid.
        
        callback(true)
    }
    
    private func configureView () {
        // If no account exists. Remove the login box to include only the option
        // for creating new account. In other case display login box with the
        // account name
    }
    
    // MARK: Wireframe (Navigation)
    private func navigateToProjectList () {
        performSegue(withIdentifier: "login_to_projectlist", sender: nil)
    }
    
    private func navigateToSignUp () {
        performSegue(withIdentifier: "login_to_signup", sender: nil)
    }
    
}
