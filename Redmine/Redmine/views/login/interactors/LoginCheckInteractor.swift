//
//  LoginCheckInteractor.swift
//  Redmine
//
//  Created by David Martinez on 19/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class LoginCheckInteractor: NSObject, LoginCheckInteractorInterface {
    
    func loginCheck(_ account: Account, _ completion: @escaping (Bool) -> ()) throws {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let session = appDelegate?.defaultSession else { throw LoginCheckError.noUrlSessionDefined }
        
        let accountEntity = ApiRestAccountEntity()
        accountEntity.host = account.host
        accountEntity.name = account.name
        accountEntity.token = account.token
        
        let restUser = ApiRestUser(session, accountEntity)
        let options : ApiRestUser.AdditionalOptions? = nil
        restUser.getMe(options, { (responseUrl : URL?, response : URLResponse?, error : ApiRestUser.ApiRestUserError?) in
            DispatchQueue.main.sync {
                completion (error == nil)
            }
        })
    }
    
}
