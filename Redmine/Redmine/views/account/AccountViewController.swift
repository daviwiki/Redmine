//
//  AccountViewController.swift
//  Redmine
//
//  Created by David Martinez on 29/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController, AccountLayoutInterface,
UITableViewDataSource, UITableViewDelegate {

    private var presenter : AccountPresenterInterface!
    private var accounts : [Account]?
    @IBOutlet weak var tableView : UITableView!
    
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
        presenter.loadAccounts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: AccountLayoutInterface
    func showAccounts(_ accounts: [Account]) {
        self.accounts = accounts
        tableView.reloadData()
    }
    
    func refreshAccount(_ account: Account) {
        guard let index = accounts?.index(of: account) else { return }
        accounts![index] = account
        
        let indexPath = IndexPath(row: index, section: 0)
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
    }
    
    func removeAccount(_ account: Account) {
        guard let index = accounts?.index(of: account) else { return }
        accounts?.remove(at: index)
        tableView.beginUpdates()
        let indexPath = IndexPath(row: index, section: 0)
        tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        tableView.endUpdates()
    }
    
    // MARK: Actions
    @IBAction func actionOnCancel (_ sender : Any?) {
        // TODO: Move to a router
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionOnEdit (_ sender : Any?) {
        let editing = !tableView.isEditing
        tableView.setEditing(editing, animated: true)
    }
    
    // MARK: Delegates (UITableViewDataSource, UITableViewDelegate)
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = accounts?.count else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "accountcell", for: indexPath) as? AccountViewCell
        let account = accounts![indexPath.row]
        cell?.showAccount(account)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            let account = accounts![indexPath.row]
            presenter.removeAccount(account)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let account = accounts![indexPath.row]
        presenter.selectAccount(account)
    }
    
    // MARK: Internal (inject)
    private func injections () {
        presenter = AccountFactory.getInstance().getPresenter()
    }
    
}

class AccountViewCell : UITableViewCell {
    
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var hostLabel : UILabel!
    @IBOutlet weak var tokenLabel : UILabel!
    
    func showAccount (_ account : Account) {
        let titleSuffix = account.isSelected ? "(Active)" : ""
        nameLabel.text = "\(account.name) \(titleSuffix)"
        hostLabel.text = "host : \(account.host)"
        
        let token = account.token
        let offset = min(6, token.characters.count)
        let endIndex = token.index(token.endIndex, offsetBy: -offset)
        let endToken = account.token.substring(from: endIndex)
        tokenLabel.text = "token : ****\(endToken)"
    }
}
