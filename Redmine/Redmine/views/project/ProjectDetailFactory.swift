//
//  ProjectDetailFactory.swift
//  Redmine
//
//  Created by David Martinez on 14/11/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class ProjectDetailFactory: NSObject {

    private static let instance = ProjectDetailFactory()
    
    static func getInstance () -> ProjectDetailFactory {
        return instance
    }
    
    func getPresenter () -> ProjectDetailPresenterInterface {
        return ProjectDetailPresenter(getIssuesInteractor())
    }
    
    func getIssuesInteractor () -> GetIssuesInterface {
        return GetIssuesInteractor()
    }
    
    private override init() {
        super.init()
    }
    
}
