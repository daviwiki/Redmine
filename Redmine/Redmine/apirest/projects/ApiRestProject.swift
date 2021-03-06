//
//  ApiRestProject.swift
//  Redmine
//
//  Created by David Martinez on 26/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class ApiRestProject: NSObject {

    private var session : URLSession!
    private var account : ApiRestAccountEntity!
    
    private let projectList = "/projects.json"
    private let projectDetail = "/projects/%@.json"
    
    enum ApiRestProjectError : Error {
        case cannotBuildUrl
        case notHttpResponse
        case unauthorized
        case forbidden
    }
    
    struct AdditionalOptions : OptionSet {
        let rawValue: Int
        static let trackers = AdditionalOptions(rawValue: 1 << 0)
        static let issueCategories = AdditionalOptions(rawValue: 1 << 1)
        static let enabledModules = AdditionalOptions(rawValue: 1 << 2)
    }
    
    init(_ session : URLSession, _ account : ApiRestAccountEntity) {
        self.session = session
        self.account = account
    }
    
    // MARK: Services
    func getProjectList (_ options : AdditionalOptions?, _ page : Int, _ completion : @escaping (URL?, URLResponse?, ApiRestProjectError?) -> Void) {
        let url = account.host + projectList
        let limit = 20
        let startOffset = "\(page*20)"
        
        var queryItems : [URLQueryItem] = []
        queryItems.append(URLQueryItem(name: "offset", value: startOffset))
        queryItems.append(URLQueryItem(name: "limit", value: "\(limit)"))
        queryItems.append(URLQueryItem(name: "key", value: account.token))
        
        var urlComponents = URLComponents(string: url)
        urlComponents?.queryItems = queryItems
        
        guard let finalUrl = urlComponents?.url else {
            completion(nil, nil, ApiRestProjectError.cannotBuildUrl)
            return
        }
        
        get(finalUrl, options, completion)
    }
    
    func getProjectDetail (_ projectId : String, _ options : AdditionalOptions?, _ completion : @escaping (URL?, URLResponse?, ApiRestProjectError?) -> Void) {
        let path = String(format: projectDetail, projectId)
        let url = account.host + path
        
        var queryItems : [URLQueryItem] = []
        queryItems.append(URLQueryItem(name: "key", value: account.token))
        
        var urlComponents = URLComponents(string: url)
        urlComponents?.queryItems = queryItems
        
        guard let finalUrl = urlComponents?.url else {
            completion(nil, nil, ApiRestProjectError.cannotBuildUrl)
            return
        }
        
        get(finalUrl, options, completion)
    }
    
    private func get (_ url : URL, _ options : AdditionalOptions?, _ completion : @escaping (URL?, URLResponse?, ApiRestProjectError?) -> Void) {
        
        // TODO: Implements query with the AdditionalOptions given
        
        let request = URLRequest(url: url)
        print("[PROJECT] Requesting \(request)")
        
        let task = session.downloadTask(with: url, completionHandler: { (responseUrl : URL?, response : URLResponse?, error : Error?) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(responseUrl, response, ApiRestProjectError.notHttpResponse)
                return
            }
            
            if (httpResponse.statusCode == 401) {
                completion(responseUrl, response, ApiRestProjectError.unauthorized)
            } else if (httpResponse.statusCode == 403) {
                completion(responseUrl, response, ApiRestProjectError.forbidden)
            } else {
                completion(responseUrl, response, nil)
            }
        })
        
        task.resume()
    }
}
