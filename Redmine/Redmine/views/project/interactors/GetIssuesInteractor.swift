//
//  GetIssuesInteractor.swift
//  Redmine
//
//  Created by David Martinez on 14/11/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class GetIssuesInteractor: NSObject, GetIssuesInterface {

    func getIssues(_ account: Account, _ project: Project, _ page: Int, _ completion: @escaping ([Issue]) -> Void) {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let session = appDelegate?.defaultSession else {
            completion([])
            return
        }
        
        let accountEntity = ApiRestAccountEntity()
        accountEntity.host = account.host
        accountEntity.name = account.name
        accountEntity.token = account.token
        
        let restIssues = ApiRestIssues(session, accountEntity)
        restIssues.getIssuesList(
            project.id,
            page,
            { (responseUrl : URL?, response : URLResponse?, error : ApiRestIssues.ApiRestIssuesError?) in
                
                var issues : [Issue] = []
                defer {
                    DispatchQueue.main.sync {
                        completion (issues)
                    }
                }
                
                guard responseUrl != nil else { return }
                
                let builder = GetAllIssuesBuilder()
                issues = builder.buildFromUrl(responseUrl!)
            }
        )
    }
}

class GetAllIssuesBuilder : NSObject {
    
    func buildData (_ data : Data?) -> [Issue] {
        guard data != nil else { return [] }
        guard let json = toJson(data: data!) as? [String : Any] else { return [] }
        guard let issues = json["issues"] as? [[String : Any]] else { return [] }
        
        var issuesList : [Issue] = []
        for jsonProject in issues {
            
            guard let idInt = jsonProject["id"] as? Int else { continue }
            guard let name = jsonProject["subject"] as? String else { continue }
            
            guard let status = jsonProject["status"] as? [String: Any] else { continue }
            guard let statusName = status["name"] as? String else { continue }
            guard let percent = jsonProject["done_ratio"] as? Int else { continue }
            
            let issue = Issue()
            issue.id = "\(idInt)"
            issue.name = name
            issue.status = statusName
            issue.percent = percent
            
            issuesList.append(issue)
        }
        
        return issuesList
    }
    
    func buildFromUrl (_ responseUrl : URL) -> [Issue] {
        var projects : [Issue] = []
        
        do {
            let data = try Data(contentsOf: responseUrl)
            projects = buildData(data)
        } catch {
            print(error)
        }
        
        return projects
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
