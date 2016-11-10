//
//  ProjectListFactory.swift
//  Redmine
//
//  Created by David Martinez on 24/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class ProjectListFactory: NSObject {

    enum ProjectListError : Error {
        case NoController
    }
    
    private static let instance = ProjectListFactory()
    

    static func getInstance () -> ProjectListFactory {
        return instance
    }
    
    func getPresenter () -> ProjectListPresenterInterface {
        return ProjectListPresenter()
    }
    
    func getSearchLastProjectsInteractor () -> GetLatestsProjectsInterface {
        return GetLatestsProjectsInteractor()
    }
    
    func getSearchAllProjectsInteractor () -> GetAllProjectsInterface {
        return GetAllProjectsInteractor()
    }
    
    private override init() {
        super.init()
    }
    
}
