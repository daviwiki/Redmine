//
//  ATESignUpViewController.swift
//  Redmine
//
//  Created by David Martinez on 26/9/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, SignUpLayoutInterface {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var formStackView : UIStackView!

    weak var nameAnimatedTextView : SignUpAnimatedTextView!
    weak var hostAnimatedTextView : SignUpAnimatedTextView!
    weak var tokenAnimatedTextView : SignUpAnimatedTextView!
    
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
        mountSignUpBoxes()
        internacionalize()
        addHideKeyboardGesture()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: SignUpLayoutInterface    
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
        presenter.onCreateAccount (
            view: self,
            name: nameAnimatedTextView.getTextField().text,
            host: hostAnimatedTextView.getTextField().text,
            token: tokenAnimatedTextView.getTextField().text)
    }
    
    @objc private func actionHideKeyboard (sender : AnyObject?) {
        view.endEditing(true)
    }
    
    // MARK: Solve injetions
    private func injections () {
        presenter = SignUpFactory.getSignUpPresenter()
    }
    
    // MARK: Internal
    private func roundCorner (view : UIView, radius : CGFloat) {
        view.clipsToBounds = true
        view.layer.cornerRadius = radius
    }
    
    private func mountSignUpBoxes () {
        self.view.layoutIfNeeded()
        
        let nib = UINib(nibName: "SignUpAnimatedTextView", bundle: nil)
        let accountNameView = nib.instantiate(withOwner: nil, options: nil).first as? SignUpAnimatedTextView
        accountNameView!.heightAnchor.constraint(equalToConstant: 60).isActive = true
        accountNameView!.widthAnchor.constraint(equalToConstant: formStackView.frame.width).isActive = true
        nameAnimatedTextView = accountNameView
        
        let accountHostView = nib.instantiate(withOwner: nil, options: nil).first as? SignUpAnimatedTextView
        accountHostView!.heightAnchor.constraint(equalToConstant: 60).isActive = true
        accountHostView!.widthAnchor.constraint(equalToConstant: formStackView.frame.width).isActive = true
        hostAnimatedTextView = accountHostView
        
        let accountTokenView = nib.instantiate(withOwner: nil, options: nil).first as? SignUpAnimatedTextView
        accountTokenView!.heightAnchor.constraint(equalToConstant: 60).isActive = true
        accountTokenView!.widthAnchor.constraint(equalToConstant: formStackView.frame.width).isActive = true
        tokenAnimatedTextView = accountTokenView
        
        formStackView.addArrangedSubview(accountNameView!)
        formStackView.addArrangedSubview(accountHostView!)
        formStackView.addArrangedSubview(accountTokenView!)
        formStackView.translatesAutoresizingMaskIntoConstraints = false;
        formStackView.layoutIfNeeded()
    }
    
    private func internacionalize () {
        var message : String?
        
        message = getLocalizable(fromId: "account_window_title")
        self.title = message
        
        message = getLocalizable(fromId: "account_name_placeholder")
        nameAnimatedTextView.getTitleLabel().text = message
        
        message = getLocalizable(fromId: "account_host_placeholder")
        hostAnimatedTextView.getTitleLabel().text = message
        
        message = getLocalizable(fromId: "account_token_placeholder")
        tokenAnimatedTextView.getTitleLabel().text = message
        
        message = getLocalizable(fromId: "account_singup_button_name")
        signUpButton?.setTitle(message, for: UIControlState.normal)
    }
    
    private func getLocalizable (fromId id : String) -> String? {
        return NSLocalizedString(id, tableName: localizableFileName, bundle: Bundle.main, value: "", comment: "")
    }
    
    private func addHideKeyboardGesture () {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(actionHideKeyboard(sender:)))
        view.addGestureRecognizer(gesture)
    }
    
}
