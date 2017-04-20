//
//  LPTextFieldCell.swift
//  LPSQLiteDB
//
//  Created by Lomesh Pansuriya on 18/04/17.
//  Copyright © 2017 Lomesh Pansuriya. All rights reserved.
//

import UIKit

class LPTextFieldCell: UITableViewCell {

    @IBOutlet weak var txtContent: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
