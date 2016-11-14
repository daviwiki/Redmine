//
//  ATEProjectDetailViewController.swift
//  Redmine
//
//  Created by David Martinez on 22/9/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class ProjectDetailViewController: UIViewController, ProjectDetailLayoutInterface,
UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var issuesTableView : UITableView!
    @IBOutlet weak var loadingView : UIView!
    @IBOutlet weak var messageView : UIView!
    @IBOutlet weak var messageLabel : UILabel!
    
    private var account : Account!
    private var project : Project!
    
    private var presenter : ProjectDetailPresenterInterface!
    private var issues : [Issue] = []
    
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
        presenter.bind(self)
        presenter.loadIssues(account, project)
        
        // TODO: Pull to refresh
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: ProjectDetailLayoutInterface
    func setAccount(account: Account) {
        self.account = account
    }
    
    func setProject(project: Project) {
        self.project = project
    }
    
    func showLoading () {
        loadingView.isHidden = false
        messageView.isHidden = true
        issuesTableView.isHidden = true
    }
    
    func reloadIssuesInfo(_ issues: [Issue]) {
        loadingView.isHidden = true
        messageView.isHidden = true
        issuesTableView.isHidden = false
        
        self.issues.removeAll()
        self.issues.append(contentsOf: issues)
        issuesTableView.reloadData()
    }
    
    func showIssuesInfo (_ issues : [Issue]) {
        loadingView.isHidden = true
        messageView.isHidden = true
        issuesTableView.isHidden = false
        
        self.issues.append(contentsOf: issues)
        issuesTableView.reloadData()
    }
    
    func showError (_ message : String) {
        loadingView.isHidden = true
        messageView.isHidden = false
        issuesTableView.isHidden = true
        
        messageLabel.text = message
    }
    
    // MARK: UITableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return issues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "issuecell", for: indexPath) as! IssueListCell
        
        let issue = issues[indexPath.row]
        cell.showIssue(issue)
        
        if (indexPath.row == issues.count - 1) {
            presenter.loadNextIssues(account, project)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: Navigate to issue detail
    }
    
    // MARK: Private
    func injections() {
        presenter = ProjectDetailFactory.getInstance().getPresenter()
    }
}
