//
//  GetAllProjectsInterface.swift
//  Redmine
//
//  Created by David Martinez on 24/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

protocol GetAllProjectsInterface {
    
    func getAllProjects(_ account : Account, _ page : Int, _ completion: @escaping ([Project]) -> Void)
    
}
