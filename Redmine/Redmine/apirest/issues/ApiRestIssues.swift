//
//  ApiRestIssues.swift
//  Redmine
//
//  Created by David Martinez on 10/11/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class ApiRestIssues: NSObject {

    private var session : URLSession!
    private var account : ApiRestAccountEntity!
    
    private let issuesList = "/issues.json"
    private let issuesDetail = "/issues/%@.json"
    
    enum ApiRestIssuesError : Error {
        case cannotBuildUrl
        case notHttpResponse
        case unauthorized
        case forbidden
    }
    
    struct AdditionalIssuesDetailOptions : OptionSet {
        let rawValue: Int
        static let children = AdditionalIssuesDetailOptions(rawValue: 1 << 0)
        static let attachment = AdditionalIssuesDetailOptions(rawValue: 1 << 1)
        static let relations = AdditionalIssuesDetailOptions(rawValue: 1 << 2)
        static let changesets = AdditionalIssuesDetailOptions(rawValue: 1 << 3)
        static let journals = AdditionalIssuesDetailOptions(rawValue: 1 << 4)
        static let watchers = AdditionalIssuesDetailOptions(rawValue: 1 << 5)
    }
    
    init(_ session : URLSession, _ account : ApiRestAccountEntity) {
        self.session = session
        self.account = account
    }
    
    func getIssuesList (
        _ projectId : String,
        _ page : Int,
        _ completion : @escaping (URL?, URLResponse?, ApiRestIssuesError?) -> Void) {
        
        let limit = 20
        let startOffset = "\(page*20)"
        let url = account.host + issuesList
        
        var queryItems : [URLQueryItem] = []
        queryItems.append(URLQueryItem(name: "projectId", value: projectId))
        queryItems.append(URLQueryItem(name: "offset", value: startOffset))
        queryItems.append(URLQueryItem(name: "limit", value: "\(limit)"))
        queryItems.append(URLQueryItem(name: "key", value: account.token))
        
        var urlComponents = URLComponents(string: url)
        urlComponents?.queryItems = queryItems
        
        guard let finalUrl = urlComponents?.url else {
            completion(nil, nil, ApiRestIssuesError.cannotBuildUrl)
            return
        }
        
        let request = URLRequest(url: finalUrl)
        print("[ISSUES] Requesting \(request)")
        
        let task = session.downloadTask(with: finalUrl, completionHandler: { (responseUrl : URL?, response : URLResponse?, error : Error?) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(responseUrl, response, ApiRestIssuesError.notHttpResponse)
                return
            }
            
            if (httpResponse.statusCode == 401) {
                completion(responseUrl, response, ApiRestIssuesError.unauthorized)
            } else if (httpResponse.statusCode == 403) {
                completion(responseUrl, response, ApiRestIssuesError.forbidden)
            } else {
                completion(responseUrl, response, nil)
            }
        })
        
        task.resume()
    }
    
    
}
