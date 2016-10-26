//
//  GetAllProjectsInteractor.swift
//  Redmine
//
//  Created by David Martinez on 24/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class GetAllProjectsInteractor: NSObject, GetAllProjectsInterface {
    
    func getAllProjects(_ account : Account, _ completion: @escaping ([Project]) -> Void) {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let session = appDelegate?.defaultSession else {
            completion([])
            return
        }
        
        let accountEntity = ApiRestAccountEntity()
        accountEntity.host = account.host
        accountEntity.name = account.name
        accountEntity.token = account.token
        
        let restProject = ApiRestProject(session, accountEntity)
        let options : ApiRestProject.AdditionalOptions? = nil
        restProject.getProjectList(options) { (responseUrl : URL?, response : URLResponse?, error : ApiRestProject.ApiRestProjectError?) in
            
            DispatchQueue.main.sync {
                // TODO: Send Data
            }
        }
    }
    
}

class GetAllProjectsBuilder : NSObject {
    
    func buildData (_ data : Data?) -> [Project] {
        guard data != nil else { return [] }
        guard let json = toJson(data: data!) as? [String : Any] else { return [] }
        guard let projects = json["projects"] as? [[String : Any]] else { return [] }
        
        var projectList : [Project] = []
        for jsonProject in projects {
            
            guard let idInt = jsonProject["id"] as? Int else { continue }
            guard let name = jsonProject["name"] as? String else { continue }
            
            let project = Project()
            project.id = "\(idInt)"
            project.name = name
            
            projectList.append(project)
        }
        
        return projectList
    }
    
    func buildData (_ data : Data?, _ completion : ([Project]) -> Void) {
        
    }
    
    func buildFromUrl (_ responseUrl : URL?, _ completion : ([Project]) -> Void) {
        
    }
    
    private func toJson(data : Data) -> Any? {
        var json : Any? = nil
        do {
            json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
        } catch {
            print(error)
        }
        
        return json
    }
}
