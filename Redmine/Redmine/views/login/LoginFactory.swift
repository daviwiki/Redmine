//
//  LoginFactory.swift
//  Redmine
//
//  Created by David Martinez on 18/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class LoginFactory: NSObject {

    enum FactoryError : Error {
        case NoController
    }
    
    private weak var originController : UIViewController?
    
    override init() {
        super.init()
    }
    
    /**
     Set the controller that will be used inside the factory for build the 
     instances.
     - Parameters:
     controller : the controller where navigations starts
    */
    func setOriginController(controller : UIViewController) {
        originController = controller
    }
    
    func getPresenter () -> LoginPresenterInterface {
        return LoginPresenter(factory: self)
    }
    
    /**
     Build the router class. Could throw an exception if the controller
     defined for this factory is nil
    */
    func getRouter () throws -> LoginRouterInterface {
        if (originController == nil) {
            throw FactoryError.NoController
        }
        return LoginRouter(controller: originController!)
    }
    
    func getCheckSyncInteractor () -> LoginCheckInteractorInterface {
        return LoginCheckInteractor()
    }
    
}
