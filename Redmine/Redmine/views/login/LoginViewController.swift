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
    @IBOutlet weak var loginButton : UIButton!
    @IBOutlet weak var accountsContainer : UIView!
    
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
        
        // Next call is neccessary before calculate roundCorner method
        // or before call any function that needs to ask subviews size
        // cause system is generating 1000x1000 view size at this point
        // instead of real sizes
        view.layoutIfNeeded()
        
        roundCorner(view: loginButton, radius: 6.0)
        accountsContainer.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.presenter.onViewAppear(view: self)
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
        accountsContainer.isHidden = true
    }
    
    func showAccount(account: Account) {
        accountsContainer.isHidden = false
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
    
    // MARK: Internal
    private func roundCorner (view : UIView, radius : CGFloat) {
        view.clipsToBounds = true
        view.layer.cornerRadius = radius
    }
    
}
