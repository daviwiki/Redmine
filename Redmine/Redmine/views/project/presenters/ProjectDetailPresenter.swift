//
//  ProjectDetailPresenter.swift
//  Redmine
//
//  Created by David Martinez on 14/11/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class ProjectDetailPresenter: NSObject, ProjectDetailPresenterInterface {

    private weak var view : ProjectDetailLayoutInterface?
    private var getIssuesInteractor : GetIssuesInterface!
    
    private var issues : [Issue] = []
    private var currentPage : Int = 0;
    private static let NO_MORE_CONTENTS : Int = -1;
    
    func bind(_ view: ProjectDetailLayoutInterface) {
        self.view = view
    }
    
    func unbind(_ view : ProjectDetailLayoutInterface) {
        self.view = nil
    }
    
    func loadIssues(_ account : Account, _ project: Project!) {
        view?.showLoading()
        currentPage = 0
        issues.removeAll()
        view?.reloadIssuesInfo([])
        
        getIssuesInteractor.getIssues(account, project, currentPage, { [weak self] (issues : [Issue]) in
            if (issues.count == 0) {
                self?.currentPage = ProjectDetailPresenter.NO_MORE_CONTENTS
                // TODO : Move to localized file
                self?.view?.showError("No issues to be displayed")
            } else {
                self?.currentPage += 1
                self?.view?.reloadIssuesInfo(issues)
            }
        })
    }
    
    func loadNextIssues(_ account : Account, _ project: Project) {
        if (currentPage == ProjectDetailPresenter.NO_MORE_CONTENTS) {
            return
        }
        
        getIssuesInteractor.getIssues(account, project, currentPage, { [weak self] (issues : [Issue]) in
            if (issues.count == 0) {
                self?.currentPage = ProjectDetailPresenter.NO_MORE_CONTENTS
            } else {
                self?.currentPage += 1
                self?.view?.showIssuesInfo(issues)
            }
        })
    }
    
    func refreshIssues(_ account : Account, _ project: Project) {
        loadIssues(account, project)
    }
    
    init(_ getIssuesInteractor : GetIssuesInterface) {
        self.getIssuesInteractor = getIssuesInteractor
    }
    
}
