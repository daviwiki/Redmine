//
//  GetIssuesInterface.swift
//  Redmine
//
//  Created by David Martinez on 14/11/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

protocol GetIssuesInterface : NSObjectProtocol {
    
    func getIssues (
        _ account : Account,
        _ project : Project, 
        _ page : Int,
        _ completion : @escaping ([Issue]) -> Void)
    
}
