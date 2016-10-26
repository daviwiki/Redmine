//
//  ProjectListPresenterInterface.swift
//  Redmine
//
//  Created by David Martinez on 24/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

protocol ProjectListPresenterInterface {
    
    func onViewAppear (_ view : ProjectListLayoutInterface)
    func navigateProject (_ project : Project)
    
}
