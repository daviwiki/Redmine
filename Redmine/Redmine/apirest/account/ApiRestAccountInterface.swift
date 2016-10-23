//
//  ApiRestAccount.swift
//  Redmine
//
//  Created by David Martinez on 22/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

protocol ApiRestAccountInterface {
    
    var name : String { get }
    var host : String { get }
    var token : String { get }
    
}
