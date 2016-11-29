//
//  LoginCheckInteractor.swift
//  Redmine
//
//  Created by David Martinez on 19/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class LoginCheckInteractor: NSObject, LoginCheckInteractorInterface {
    
    private var apiRest : ApiRestUser!
    
    func setApiRest (_ apiRest : ApiRestUser) {
        self.apiRest = apiRest
    }
    
    func loginCheck(_ account: Account, _ completion: @escaping (Bool) -> ()) throws {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let session = appDelegate?.defaultSession else { throw LoginCheckError.noUrlSessionDefined }
        
        let accountEntity = ApiRestAccountEntity()
        accountEntity.host = account.host
        accountEntity.name = account.name
        accountEntity.token = account.token
        
        apiRest.setSession(session)
        apiRest.setAccount(accountEntity)

        let options : ApiRestUser.AdditionalOptions? = nil
        apiRest.getMe(options, { (responseUrl : URL?, response : URLResponse?, error : ApiRestUser.ApiRestUserError?) in
            DispatchQueue.main.sync {
                // TODO: Cambiar para no devolver solo un boolean sino el motivo
                // del error
                completion (error == nil)
            }
        })
    }
    
}
