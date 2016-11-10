//
//  ATEProjectListViewController.swift
//  Redmine
//
//  Created by David Martinez on 22/9/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class ProjectListViewController: UIViewController, ProjectListLayoutInterface,
UITableViewDataSource, UITableViewDelegate {

    private var account : Account!
    private var projects : [Project] = []
    private var presenter : ProjectListPresenterInterface!
    private var selectedProject : Project!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    
    private let segueProjectDetail = "projectlist_to_projectdetail"
    
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
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.loadProjects(account)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: ProjectListInterface
    func setAccount(account: Account) {
        self.account = account
    }
    
    func showLoading() {
        loadingView.isHidden = false
        tableView.isHidden = true
        messageView.isHidden = true
    }
    
    func showNoProjects() {
        loadingView.isHidden = true
        tableView.isHidden = true
        messageView.isHidden = false
        
        // TODO: Move to localized strings
        messageLabel.text = "No tiene ningún proyecto vinculado a su cuenta"
    }
    
    func showLatestProjects(_ projects: [Project]) {
        // TODO:
    }
    
    func showAllProjects(_ projects: [Project]) {
        loadingView.isHidden = true
        tableView.isHidden = false
        messageView.isHidden = true
        
        self.projects.removeAll()
        self.projects.append(contentsOf: projects)
        tableView.reloadData()
    }
    
    // MARK: Internal
    private func injections () {
        presenter = ProjectListFactory.getInstance().getPresenter()
    }
    
    // MARK: TableView Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "projectcell", for: indexPath) as! ProjectListCell
        
        let project = projects[indexPath.row]
        cell.nameLabel.text = project.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedProject = projects[indexPath.row]
        performSegue(withIdentifier: segueProjectDetail, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let layout = segue.destination as? ProjectDetailLayoutInterface {
            layout.setAccount(account: account)
            layout.setProject(project: selectedProject)
        }
    }
    
}
