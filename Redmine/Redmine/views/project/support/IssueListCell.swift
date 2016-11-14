//
//  IssueListCellTableViewCell.swift
//  Redmine
//
//  Created by David Martinez on 14/11/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class IssueListCell: UITableViewCell {

    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var statusLabel : UILabel!
    
    // MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: Services
    func showIssue (_ issue : Issue) {
        nameLabel.text = issue.name
        statusLabel.text = "Status: \(issue.status) (\(issue.percent)%)"
    }

}
