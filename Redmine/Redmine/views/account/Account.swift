//
//  Account.swift
//  Redmine
//
//  Created by David Martinez on 28/9/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class Account: NSObject, NSCoding, ApiRestAccountInterface {

    var name : String = ""
    var host : String = ""
    var token : String = ""
    
    // MARK: Lifecycle
    override init() {
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(host, forKey: "host")
        aCoder.encode(token, forKey: "token")
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        host = aDecoder.decodeObject(forKey: "host") as! String
        token = aDecoder.decodeObject(forKey: "token") as! String
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let o = object as? Account else { return false }
        return name.compare(o.name) == ComparisonResult.orderedSame
    }
}
