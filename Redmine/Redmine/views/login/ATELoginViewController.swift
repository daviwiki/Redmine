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
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Actions
    @IBAction func actionLogin (sender : AnyObject) {
        // TODO: Mostrar loading
        if (!isValidUsername(username: usernameTextField.text)) {
            showInvalidUsernameError()
            return
        }
        
        if (!isValidPassword(password: passwordTextField.text)) {
            showInvalidPasswordError()
            return
        }
        
        login(user: usernameTextField.text!, token: passwordTextField.text!)
    }
    
    // MARK: Internal (Login checker)
    private func isValidUsername (username : String?) -> Bool {
        // TODO: Implementar
        return true
    }
    
    private func isValidPassword (password : String?) -> Bool {
        // TODO: Implementar
        return true
    }
    
    // MARK: Internal (Navigation)
    private func navigateToHome () {
        performSegue(withIdentifier: "login_to_projectlist", sender: nil)
    }
    
    // MARK: Internal (Errors)
    private func showLoginError (errorType type : ATELoginErrorType) {
        // TODO: Implementar
    }
    
    private func showInvalidUsernameError () {
        // TODO: Implementar
    }
    
    private func showInvalidPasswordError () {
        // TODO: Implementar
    }
    
    // MARK: Internal (Http - Services)
    private func login (user : String, token : String) {
        let provider : ATELoginProvider = ATELoginProvider()
        provider.login(
            withUsername: user,
            andToken: token,
            onSuccess: { (user : ATEUser) in
                navigateToHome()
            },
            onError: { (error : ATELoginErrorType) in
                showLoginError(errorType: error)
            }
        )
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */


}
