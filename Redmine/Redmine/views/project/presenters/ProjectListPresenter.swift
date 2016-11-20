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
    
    private let NO_MORE_LOADS : Int = -1
    
    private var projects : [Project] = []
    private var currentPage : Int = 0;
    private var isLoading = false;
    
    func bind(_ view: ProjectListLayoutInterface) {
        self.view = view
    }
    
    func unbind(_ view: ProjectListLayoutInterface) {
        self.view = nil
    }
    
    func loadProjects(_ account : Account) {
        guard !isLoading else { return }
        guard currentPage == 0 else { return }
        
        view?.cleanProjectList()
        isLoading = true
        
        view?.showLoading()
        let loadProjectsInteractor = GetAllProjectsInteractor()
        loadProjectsInteractor.getAllProjects(account, currentPage) { [weak self] (projects : [Project]) in
            guard let myself = self else { return }
            myself.isLoading = false
            
            if (projects.count == 0) {
                myself.view?.showNoProjects()
                myself.currentPage = myself.NO_MORE_LOADS
            } else {
                myself.currentPage += 1
                myself.view?.appendProjects(projects)
            }
        }
    }
    
    func loadNextProjects (_ account : Account) {
        guard !isLoading else { return }
        guard currentPage != NO_MORE_LOADS else { return }
        isLoading = true
        
        let loadProjectsInteractor = GetAllProjectsInteractor()
        loadProjectsInteractor.getAllProjects(account, currentPage) { [weak self] (projects : [Project]) in
            guard let myself = self else { return }
            myself.isLoading = false
            
            if (projects.count > 0) {
                myself.projects.append(contentsOf: projects)
                myself.currentPage += 1
                myself.view?.appendProjects(projects)
            } else {
                myself.currentPage = myself.NO_MORE_LOADS
            }
        }
    }
    
    func refreshProjects (_ account : Account) {
        guard !isLoading else { return }
        
        view?.cleanProjectList()
        currentPage = 0
        projects.removeAll()
        loadProjects(account)
    }
    
    // MARK: Private
    
}
