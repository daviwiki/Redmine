//
//  ProjectListCell.swift
//  Redmine
//
//  Created by David Martinez on 10/11/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class ProjectListCell: UITableViewCell {

    @IBOutlet weak var nameLabel : UILabel!

    // TODO: Crear metodo publico y prohibir set directamente sobre la UI
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
