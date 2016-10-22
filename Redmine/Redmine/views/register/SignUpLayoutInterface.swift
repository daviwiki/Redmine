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
     If a error ocurrs, a alert view must be shown with the message
     given.
     - Parameters:
        message, the message to display inside the alert
    */
    func showError (message : String)
    
}
