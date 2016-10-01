//
//  SignUpLayoutInterface.swift
//  Redmine
//
//  Created by David Martinez on 1/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

protocol SignUpLayoutInterface {
 
    /**
     Display name placeholder
    */
    func showNamePlaceholder (name : String)
    
    /**
     Display host placeholder
     */
    func showHostPlaceholder (name : String)
    
    /**
     Display token placeholder
     */
    func showTokenPlaceholder (name : String)
    
    /**
     Display signup button name
     */
    func showSignUpButtonName (name : String)
    
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
    
    
}
