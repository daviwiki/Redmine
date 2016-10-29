//
//  ATESignUpViewController.swift
//  Redmine
//
//  Created by David Martinez on 26/9/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, SignUpLayoutInterface,
SignUpAnimatedTextViewDelegate {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var formStackView : UIStackView!
    @IBOutlet weak var scrollView : UIScrollView!

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
        presenter.bind(view: self)
        addHideKeyboardGesture()
        mountSignUpBoxes()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        roundCorner(view: signUpButton, radius: 6.0)
        internacionalize()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addKeyboardEventsListeners()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeKeyboardNotifications()
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
    
    func showAccountCreated (account: Account) {
        let alertTitle = getLocalizable(fromId: "alert_title")
        let messagePattern = getLocalizable(fromId: "ok_account_created")!
        let message = String(format: messagePattern, account.name)
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let alertActionTitle = getLocalizable(fromId: "alert_ok_action")
        let action = UIAlertAction(title: alertActionTitle, style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: Actions
    @IBAction func onClickSignUp (withSender sender : UIButton) {
        createAccount()
    }
    
    @objc private func actionHideKeyboard (sender : AnyObject?) {
        view.endEditing(true)
    }
    
    @objc private func onKeyboardWillShow (notification : NSNotification) {
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + signUpButton.frame.height
        scrollView.contentInset = contentInset
    }
    
    @objc private func onKeyboardWillHide (notification : NSNotification){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    // MARK: Delegates (SignUpAnimatedTextView)
    func next(view: SignUpAnimatedTextView) {
        if (view == nameAnimatedTextView) {
            hostAnimatedTextView.focus()
        } else if (view == hostAnimatedTextView) {
            tokenAnimatedTextView.focus()
        } else {
            createAccount()
        }
    }
    
    // MARK: Internal (Solve injetions)
    private func injections () {
        presenter = SignUpFactory.getSignUpPresenter()
    }
    
    // MARK: Interal (orders)
    private func createAccount () {
        presenter.createAccount (
            name: nameAnimatedTextView.getTextField().text,
            host: hostAnimatedTextView.getTextField().text,
            token: tokenAnimatedTextView.getTextField().text)
    }
    
    // MARK: Internal (View)
    private func roundCorner (view : UIView, radius : CGFloat) {
        view.clipsToBounds = true
        view.layer.cornerRadius = radius
    }
    
    private func mountSignUpBoxes () {
        let nib = UINib(nibName: "SignUpAnimatedTextView", bundle: nil)
        let accountNameView = nib.instantiate(withOwner: nil, options: nil).first as? SignUpAnimatedTextView
        accountNameView!.heightAnchor.constraint(equalToConstant: 60).isActive = true
        accountNameView!.widthAnchor.constraint(equalToConstant: formStackView.frame.width).isActive = true
        nameAnimatedTextView = accountNameView
        nameAnimatedTextView.getTextField().returnKeyType = UIReturnKeyType.next
        nameAnimatedTextView.setDelegate(delegate: self)
        
        let accountHostView = nib.instantiate(withOwner: nil, options: nil).first as? SignUpAnimatedTextView
        accountHostView!.heightAnchor.constraint(equalToConstant: 60).isActive = true
        accountHostView!.widthAnchor.constraint(equalToConstant: formStackView.frame.width).isActive = true
        hostAnimatedTextView = accountHostView
        hostAnimatedTextView.getTextField().returnKeyType = UIReturnKeyType.next
        hostAnimatedTextView.setDelegate(delegate: self)
        
        let accountTokenView = nib.instantiate(withOwner: nil, options: nil).first as? SignUpAnimatedTextView
        accountTokenView!.heightAnchor.constraint(equalToConstant: 60).isActive = true
        accountTokenView!.widthAnchor.constraint(equalToConstant: formStackView.frame.width).isActive = true
        tokenAnimatedTextView = accountTokenView
        tokenAnimatedTextView.getTextField().returnKeyType = UIReturnKeyType.go
        tokenAnimatedTextView.setDelegate(delegate: self)
        
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
    
    private func addKeyboardEventsListeners () {
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(onKeyboardWillShow(notification:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        center.addObserver(self, selector: #selector(onKeyboardWillHide(notification:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    private func removeKeyboardNotifications () {
        NotificationCenter.default.removeObserver(self)
    }
}
