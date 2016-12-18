//
//  ProbaTableViewCell.swift
//  Proba
//
//  Created by MacBook on 27.10.16.
//  Copyright © 2016 MacBook. All rights reserved.
//

import UIKit

class UsersTableViewCell: UITableViewCell {

    @IBOutlet weak var Avatar: UIImageView!
    
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Work: UILabel!
    @IBOutlet weak var Comments: UILabel!
    
  
    
    
    
    
    
    @IBOutlet weak var AvatarUser: UIImageView!
    
    @IBOutlet weak var NameUser: UILabel!
    
    @IBOutlet weak var StatusUser: UILabel!
    
    @IBOutlet weak var ComentUser: UILabel!
    
    
    @IBOutlet weak var BackGroundUserImage: UIImageView!
    
    @IBOutlet weak var StatusImage: UIImageView!
    
    @IBOutlet weak var BackGroundUserImage1: UIView!
    
    @IBOutlet weak var BackLitleImage: UIView!
    
    
    override func awakeFromNib() {
        
        AvatarUser.alpha = 1
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
