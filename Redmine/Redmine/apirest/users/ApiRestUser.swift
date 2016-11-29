//
//  ApiRestUser.swift
//  Redmine
//
//  Created by David Martinez on 22/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class ApiRestUser: NSObject {

    private var session : URLSession!
    private var account : ApiRestAccountEntity!
    
    private let urlMe = "/users/current.json"
    
    enum ApiRestUserError : Error {
        case cannotBuildUrl
        case notHttpResponse
        case unauthorized
        case forbidden
    }
    
    struct AdditionalOptions : OptionSet {
        let rawValue: Int
        static let membership = AdditionalOptions(rawValue: 1 << 0)
        static let groups = AdditionalOptions(rawValue: 1 << 1)
    }
    
    // MARK : Lifecycle
    override init() {
        super.init()
    }
    
    init(_ session : URLSession, _ account : ApiRestAccountEntity) {
        super.init()
        self.session = session
        self.account = account
    }
    
    func setSession (_ session : URLSession) {
        self.session = session
    }
    
    func setAccount (_ account : ApiRestAccountEntity) {
        self.account = account
    }
    
    // MARK : Services
    /**
     Load the information for the user associated with the account given
     into the constructor
     - Parameters:
        options (to serve additional information in the request)
        completion (block where response are communicated)
     - Note:
        In case of error the ApiRestUserError will return a value always. 
        The "data" and "Response" recieved from the http communication are returned
        always.
     - Todo:
        options is ignored at this point
    */
    func getMe(_ options : AdditionalOptions?, _ completion : @escaping (URL?, URLResponse?, ApiRestUserError?) -> Void) {
        
        // TODO: Implements query with the AdditionalOptions given
        
        var urlComponents = URLComponents(string: account.host + urlMe)
        let keyItem = URLQueryItem(name: "key", value: account.token)
        urlComponents?.queryItems = [keyItem]
        
        guard let url = urlComponents?.url else {
            completion(nil, nil, ApiRestUserError.cannotBuildUrl)
            return
        }
        
        let request = URLRequest(url: url)
        print("[USER] Requesting \(request)")
        
        let task = session.downloadTask(with: url, completionHandler: { (responseUrl : URL?, response : URLResponse?, error : Error?) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(responseUrl, response, ApiRestUserError.notHttpResponse)
                return
            }
            
            if (httpResponse.statusCode == 401) {
                completion(responseUrl, response, ApiRestUserError.unauthorized)
            } else if (httpResponse.statusCode == 403) {
                completion(responseUrl, response, ApiRestUserError.forbidden)
            } else {
                completion(responseUrl, response, nil)
            }
        })
        
        task.resume()
    }
}
