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
    
    private static let instance = LoginFactory()
    private weak var originController : UIViewController?
    
    // MARK: Lifecycle
    static func getInstance () -> LoginFactory {
        return instance
    }
    
    private override init() {
        super.init()
    }
    
    // MARK: Config
    func setOriginController(controller : UIViewController) {
        originController = controller
    }

    // MARK: Getters
    func getPresenter () -> LoginPresenterInterface {
        let presenter = LoginPresenter()
        
        do {
            let router = try getRouter()
            presenter.setRouter(router)
        } catch {
            print(error)
        }
        
        presenter.setLoginInteractor(getCheckSyncInteractor())
        presenter.setReadAccountInteractor(getReadAccountInteractor())
        
        return presenter
    }
    
    func getRouter () throws -> LoginRouterInterface {
        if (originController == nil) {
            throw FactoryError.NoController
        }
        return LoginRouter(controller: originController!)
    }
    
    func getCheckSyncInteractor () -> LoginCheckInteractorInterface {
        let interactor = LoginCheckInteractor()
        let apiRest = ApiRestUser()
        interactor.setApiRest(apiRest)
        return interactor
    }
    
    func getReadAccountInteractor () -> LoginReadAccountsInterface {
        let readAccounts = LoginReadAccounts()
        
        readAccounts.setAccountStorage { [weak self] (interactorCallback : @escaping (AccountStorageInterface) -> Void) in
            self?.getLoginAccountStorage(interactorCallback)
        }

        return readAccounts
    }
    
    func getLoginAccountStorage (_ callback : @escaping (AccountStorageInterface) -> Void) {
        AccountStorageCoreDataFactory.getInstance().getAccountStorageManager(callback)
    }
    
}
