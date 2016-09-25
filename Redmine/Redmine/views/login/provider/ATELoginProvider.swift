//
//  ATELoginProvider.swift
//  Redmine
//
//  Created by David Martinez on 22/9/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

enum ATELoginErrorType : Error {
    case EmptyJson
    case MalformedJson
    case UserPasswordInvalid
    case AccessForbidden
    case InternalServerError
    case Unknown
}

class ATELoginProvider: NSObject {

    func login(
        withUsername username : String,
        andToken token : String,
        onSuccess success : (_ user : ATEUser) -> (),
        onError error : (_ error : ATELoginErrorType) -> ()) {
        
        // TODO: Implementar login
        success(ATEUser())
    }
    
}
