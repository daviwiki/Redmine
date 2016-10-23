//
//  LoginCheckInteractor.swift
//  Redmine
//
//  Created by David Martinez on 19/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

enum LoginCheckError : Error {
    case noUrlSessionDefined
}

protocol LoginCheckInteractorInterface {
    
    func loginCheck(_ account: Account, _ completion: @escaping (Bool) -> ()) throws
    
}
