//
//  Account.swift
//  Redmine
//
//  Created by David Martinez on 28/9/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class Account: NSObject, NSCoding {

    var name : String = ""
    var host : String = ""
    var token : String = ""
    
    var isSelected : Bool = false
    var order : Int = 0
    
    // MARK: Lifecycle
    override init() {
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(host, forKey: "host")
        aCoder.encode(token, forKey: "token")
        aCoder.encode(isSelected, forKey: "isSelected")
        aCoder.encode(order, forKey: "order")
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        host = aDecoder.decodeObject(forKey: "host") as! String
        token = aDecoder.decodeObject(forKey: "token") as! String
        isSelected = aDecoder.decodeObject(forKey: "isSelected") as! Bool
        order = aDecoder.decodeObject(forKey: "order") as! Int
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let o = object as? Account else { return false }
        return name.compare(o.name) == ComparisonResult.orderedSame
    }
}
