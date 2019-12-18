//
//  TheTableViewCell.swift
//  termProject
//
//  Created by Christian Lopez on 3/31/19.
//  Copyright © 2019 Christian Lopez. All rights reserved.
//

import UIKit

class TheTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var myLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
