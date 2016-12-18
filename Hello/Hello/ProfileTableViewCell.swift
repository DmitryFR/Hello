//
//  ProfileTableViewCell.swift
//  Proba
//
//  Created by MacBook on 03.12.16.
//  Copyright © 2016 MacBook. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {


    
    @IBOutlet weak var ChatButton: UIView!
    @IBOutlet weak var FavoritUserButton: UIView!
 
    @IBOutlet weak var ChatButtonTap: UIButton!
    @IBOutlet weak var ImageChat: UIImageView!
    @IBOutlet weak var FavoriteButtonTap: UIButton!

    @IBOutlet weak var ImageFavoriteUser: UIImageView!

    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var WrireButtom: UIButton!
    var Focus : Int!
    func aalpha () {
        
       // self.InFocus.alpha = 1
        
    }
    
   /* var im: UIImage!
    var fioo : String!
    var com : String!
    
    func cellIndexProfil (){
        
        self.AvatarOfUser.image = self.im
        self.ProbaFio.text = self.fioo
        self.CommentUser.text = self.com
        
    }*/
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //self.FioProfil.text = fio
        //self.ComentUserProfil.text = Comment
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
