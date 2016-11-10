//
//  ProjectListPresenter.swift
//  Redmine
//
//  Created by David Martinez on 24/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class ProjectListPresenter: NSObject, ProjectListPresenterInterface {

    private weak var view : ProjectListLayoutInterface?
    
    func bind(_ view: ProjectListLayoutInterface) {
        self.view = view
    }
    
    func unbind(_ view: ProjectListLayoutInterface) {
        self.view = nil
    }
    
    func loadProjects(_ account : Account) {
        view?.showLoading()
        let loadProjectsInteractor = GetAllProjectsInteractor()
        loadProjectsInteractor.getAllProjects(account) { [weak self] (projects : [Project]) in
            if (projects.count == 0) {
                self?.view?.showNoProjects()
            } else {
                self?.view?.showAllProjects(projects)
            }
        }
    }
    
    func navigateProject(_ project: Project) {
        // TODO:
    }
    
}
