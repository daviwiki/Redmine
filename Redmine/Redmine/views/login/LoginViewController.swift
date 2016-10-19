//
//  ATELoginViewController.swift
//  Redmine
//
//  Created by David Martinez on 22/9/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, LoginLayoutInterface {

    @IBOutlet weak var accountTitleLabel : UILabel!
    
    private var factory : LoginFactory!
    private var presenter : LoginPresenterInterface!
    private var selectedAccount : Account?
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        factory = LoginFactory.getInstance()
        factory.setOriginController(controller: self)
        
        presenter = factory.getPresenter()
        presenter.configureViewForPresentation(view: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.onViewAppear(view: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Services
    func showWindowTitle(title: String?) {
        self.title = title
    }
    
    func showError(message: String) {
        // TODO: Move to localized strings
        let title = "Advice"
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func showNoAccount() {
        // TODO: Show no account display
    }
    
    func showAccount(account: Account) {
        selectedAccount = account
        accountTitleLabel.text = selectedAccount?.name
    }
    
    // MARK: Actions
    @IBAction func actionOnSignUp (_ sender : UIButton) {
        presenter.onCreateAccount()
    }
    
    @IBAction func actionOnLogin (_ sender : UIButton) {
        guard selectedAccount != nil else { return }
        presenter.onLogin(account: selectedAccount!)
    }
}
