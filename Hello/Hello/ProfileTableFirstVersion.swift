//
//  ProfileTableFirstVersion.swift
//  Proba
//
//  Created by MacBook on 06.12.16.
//  Copyright © 2016 MacBook. All rights reserved.
//
// ВЫБРАННЫЙ ИЗ ТАБЛИЦЫ ПОЛЬЗОВАТЕЛЬ
import UIKit
import Firebase
import VK_ios_sdk
class ProfileTableFirstVersion:    UIViewController,  UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var BackIm: UIImageView!

    @IBOutlet weak var BackGroundImage: UIImageView!
    

    var im: UIImage!
    var fioo : String!
    var com : String!
    var origYIm : CGFloat!
    var contentSize: CGFloat! 
    var cellSize: CGFloat!
    var AlphaUpFocus: Int = 0
    var currentUser = NSMutableDictionary()
    var tok = VKAccessToken()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.backgroundColor = UIColor.clear
        self.cellSize = tableView.frame.size.width
      
        self.origYIm = self.BackIm.frame.origin.y
        self.tableView.separatorColor = UIColor.clear
        
  //self.BackIm.image = im
        
        var url:NSURL = NSURL(string: self.currentUser.value(forKey: "photo_400_orig") as! String)!
        var mydata:NSData = NSData(contentsOf: url as URL)!
        
        
        self.BackIm.image = UIImage(data: mydata as Data)

    
    }
    
    
        
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
        
    }
    
    var scrollPosition : CGFloat = 0
    
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        self.scrollPosition = tableView.contentOffset.y
        
        let SizeContent = tableView.contentSize.height
       
        if scrollPosition <= 0 {
        
            tableView.contentOffset.y = 0
        
        }
        
        if  self.scrollPosition > 0 {
            

            BackIm.frame.origin.y = self.origYIm - ((scrollPosition / SizeContent) * BackIm.frame.size.height / 2)
            BackIm.alpha = 1 - (self.scrollPosition / SizeContent) * 1.5
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        tableView.backgroundColor = UIColor.clear
        
        var celledit : UITableViewCell!
        var hightChatBattom : CGFloat = 0.0


        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SuperCell0", for: indexPath) as! ProfTableViewCell
            cell.currentUser = self.currentUser
            let CellH = cell.frame.size.width
            cell.frame.size.height = CellH
            
            cell.backgroundColor = UIColor.clear
        
            cell.chatButton.frame.size.width = cell.chatButton.frame.size.height
            cell.chatButton.layer.cornerRadius = cell.chatButton.frame.size.width / 2
            cell.chatButton.layer.borderWidth = 3
            cell.chatButton.layer.borderColor = UIColor.white.cgColor
            cell.chatButton.backgroundColor = UIColor.clear
            cell.chatButtonTap.frame.size.height = cell.chatButton.frame.size.width
            cell.chatButtonTap.frame.size.width = cell.chatButton.frame.size.height
            
            
            cell.favoriteUserButton.frame.size.width = cell.favoriteUserButton.frame.size.height
            cell.favoriteUserButton.layer.cornerRadius = cell.favoriteUserButton.frame.size.width / 2
            cell.favoriteUserButton.layer.borderWidth = 3
            cell.favoriteUserButton.layer.borderColor = UIColor.white.cgColor
            cell.favoriteUserButton.backgroundColor = UIColor.clear
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.favoriteButtonTap.frame.size.height = cell.favoriteUserButton.frame.size.width
            cell.favoriteButtonTap.frame.size.width = cell.favoriteUserButton.frame.size.height
            
            cell.chatButton.frame.origin.x = (cell.frame.size.width / 3) - (cell.chatButton.frame.size.width / 2)
             
            
            cell.favoriteUserButton.frame.origin.x = (cell.frame.size.width / 3 * 2) - (cell.favoriteUserButton.frame.size.width / 2)
            
            cell.imageChat.frame.size.height = cell.chatButton.frame.size.height / 2
            cell.imageChat.frame.size.width = cell.imageChat.frame.size.height
            cell.imageChat.frame.origin.x = cell.imageChat.frame.size.width / 2
            cell.imageChat.frame.origin.y = cell.imageChat.frame.size.height / 2
            
            cell.imageFavoriteUser.frame.size.height = cell.favoriteUserButton.frame.size.height / 2
            cell.imageFavoriteUser.frame.size.width = cell.imageFavoriteUser.frame.size.height
            cell.imageFavoriteUser.frame.origin.x = cell.imageFavoriteUser.frame.size.width / 2
            cell.imageFavoriteUser.frame.origin.y = cell.imageFavoriteUser.frame.size.height / 2
            
            cell.chatButtonTap.frame.origin.x = 0
            cell.chatButtonTap.frame.origin.y = 0
            cell.favoriteButtonTap.frame.origin.x = 0
            cell.favoriteButtonTap.frame.origin.y = 0
            cell.imageChat.alpha = 1
            cell.imageFavoriteUser.alpha = 1
           
            cell.chatButton.frame.origin.y = cell.frame.height - cell.chatButton.frame.size.height * 1.2
            cell.favoriteUserButton.frame.origin.y = cell.frame.height - cell.favoriteUserButton.frame.size.height * 1.2
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            hightChatBattom = cell.chatButton.frame.size.height
            
            celledit = cell
        }
        
        if indexPath.row == 1 {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "SuperCell1", for: indexPath) as! ProfTableViewCell
            
            cell.backgroundColor = UIColor.white
            cell.alpha = 0.6
            
            cell.frame.size.height = 10
        
        
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            celledit = cell
            
            cell.name.text = self.currentUser.value(forKey: "first_name") as! String?
            cell.fam.text = self.currentUser.value(forKey: "last_name") as! String?
            cell.gender.text = self.currentUser.value(forKey: "sex") as! String?
            cell.messageField.text = self.currentUser.value(forKey: "message") as! String?
            cell.additionalInfoField.text = self.currentUser.value(forKey: "additionalInfo") as! String?
        
        }
        
        return celledit
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //if (segue.identifier == "ToChat"){
            let vc = segue.destination as! ChatViewController
            vc.currentUser = self.currentUser
        vc.tok = self.tok
       // }
    }
    

    

}
