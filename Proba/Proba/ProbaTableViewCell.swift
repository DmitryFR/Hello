//
//  ProbaTableViewCell.swift
//  Proba
//
//  Created by MacBook on 27.10.16.
//  Copyright © 2016 MacBook. All rights reserved.
//

import UIKit

class ProbaTableViewCell: UITableViewCell {

    @IBOutlet weak var Avatar: UIImageView!
    
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Work: UILabel!
    @IBOutlet weak var Comments: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
