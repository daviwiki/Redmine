//
//  ATESignUpViewController.swift
//  Redmine
//
//  Created by David Martinez on 26/9/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, SignUpLayoutInterface {

    @IBOutlet weak var nameTextField : UITextField!
    @IBOutlet weak var hostTextField : UITextField!
    @IBOutlet weak var tokenTextField : UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    var presenter : SignUpPresenterInterface!
    let localizableFileName = "SignUp"
    
    // MARK: Lifecycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        injections()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        injections()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.configureViewForPresentation(view: self)
        roundCorner(view: signUpButton, radius: 6.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: SignUpLayoutInterface
    func showWindowTitle(title: String?) {
        self.title = title
    }
    
    func showNamePlaceholder(name: String) {
        nameTextField.placeholder = name
    }
    
    func showHostPlaceholder(name: String) {
        hostTextField.placeholder = name
    }
    
    func showTokenPlaceholder(name: String) {
        tokenTextField.placeholder = name
    }
    
    func showSignUpButtonName(name: String) {
        signUpButton?.setTitle(name, for: UIControlState.normal)
    }
    
    func showError(message: String) {
        let alertTitle = getLocalizable(fromId: "alert_title")
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let alertActionTitle = getLocalizable(fromId: "alert_ok_action")
        let action = UIAlertAction(title: alertActionTitle, style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: Actions
    @IBAction func onClickSignUp (withSender sender : UIButton) {
        presenter.onCreateAccount(
            view: self,
            name: nameTextField.text,
            host: hostTextField.text,
            token: tokenTextField.text)
    }
    
    // MARK: Solve injetions
    private func injections () {
        presenter = SignUpFactory.getSignUpPresenter()
    }
    
    // MARK: Internal
    private func getLocalizable (fromId id : String) -> String? {
        return NSLocalizedString(id, tableName: localizableFileName, bundle: Bundle.main, value: "", comment: "")
    }
    
    private func roundCorner (view : UIView, radius : CGFloat) {
        view.clipsToBounds = true
        view.layer.cornerRadius = radius
    }
}
