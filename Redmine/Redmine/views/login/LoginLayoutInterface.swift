//
//  LoginLayoutInterface.swift
//  Redmine
//
//  Created by David Martinez on 18/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

protocol LoginLayoutInterface : NSObjectProtocol {
    
    // TODO: Define methods for localization
    
    /**
     Set the title for the window
     - Parameters:
        title, if null no title will shown
     */
    func showWindowTitle (title : String?)
    
    /**
     If a error ocurrs, a alert view must be shown with the message
     given.
     - Parameters:
        message, the message to display inside the alert
     */
    func showError (message : String)
    
    /**
     Display a no account information
    */
    func showNoAccount ()
    
    /**
     Display the account information into Login window
     - Parameters:
        account, to be displayed
    */
    func showAccount (account : Account)
}
