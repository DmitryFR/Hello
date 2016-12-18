//
//  ProfileTableFirstVersion.swift
//  Proba
//
//  Created by MacBook on 06.12.16.
//  Copyright © 2016 MacBook. All rights reserved.
//
// ВЫБРАННЫЙ ИЗ ТАБЛИЦЫ ПОЛЬЗОВАТЕЛЬ
import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.backgroundColor = UIColor.clear
        self.cellSize = tableView.frame.size.width
        self.BackIm.image = im
        self.origYIm = self.BackIm.frame.origin.y
        self.tableView.separatorColor = UIColor.clear
        

        
        
        // self.UnFocus.image = #imageLiteral(resourceName: "blue_blur_by_axiol.png")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
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
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SuperCell0", for: indexPath) as! ProfileTableViewCell
            
            let CellH = cell.frame.size.width
            cell.frame.size.height = CellH
            
            cell.backgroundColor = UIColor.clear
        
            cell.ChatButton.frame.size.width = cell.ChatButton.frame.size.height
            cell.ChatButton.layer.cornerRadius = cell.ChatButton.frame.size.width / 2
            cell.ChatButton.layer.borderWidth = 3
            cell.ChatButton.layer.borderColor = UIColor.white.cgColor
            cell.ChatButton.backgroundColor = UIColor.clear
            cell.ChatButtonTap.frame.size.height = cell.ChatButton.frame.size.width
            cell.ChatButtonTap.frame.size.width = cell.ChatButton.frame.size.height
            
            
            cell.FavoritUserButton.frame.size.width = cell.FavoritUserButton.frame.size.height
            cell.FavoritUserButton.layer.cornerRadius = cell.FavoritUserButton.frame.size.width / 2
            cell.FavoritUserButton.layer.borderWidth = 3
            cell.FavoritUserButton.layer.borderColor = UIColor.white.cgColor
            cell.FavoritUserButton.backgroundColor = UIColor.clear
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.FavoriteButtonTap.frame.size.height = cell.FavoritUserButton.frame.size.width
            cell.FavoriteButtonTap.frame.size.width = cell.FavoritUserButton.frame.size.height
            
            cell.ChatButton.frame.origin.x = (cell.frame.size.width / 3) - (cell.ChatButton.frame.size.width / 2)
             
            
            cell.FavoritUserButton.frame.origin.x = (cell.frame.size.width / 3 * 2) - (cell.FavoritUserButton.frame.size.width / 2)
            
            cell.ImageChat.frame.size.height = cell.ChatButton.frame.size.height / 2
            cell.ImageChat.frame.size.width = cell.ImageChat.frame.size.height
            cell.ImageChat.frame.origin.x = cell.ImageChat.frame.size.width / 2
            cell.ImageChat.frame.origin.y = cell.ImageChat.frame.size.height / 2
            
            cell.ImageFavoriteUser.frame.size.height = cell.FavoritUserButton.frame.size.height / 2
            cell.ImageFavoriteUser.frame.size.width = cell.ImageFavoriteUser.frame.size.height
            cell.ImageFavoriteUser.frame.origin.x = cell.ImageFavoriteUser.frame.size.width / 2
            cell.ImageFavoriteUser.frame.origin.y = cell.ImageFavoriteUser.frame.size.height / 2
            
            cell.ChatButtonTap.frame.origin.x = 0
            cell.ChatButtonTap.frame.origin.y = 0
            cell.FavoriteButtonTap.frame.origin.x = 0
            cell.FavoriteButtonTap.frame.origin.y = 0
            cell.ImageChat.alpha = 1
            cell.ImageFavoriteUser.alpha = 1
           
            cell.ChatButton.frame.origin.y = cell.frame.height - cell.ChatButton.frame.size.height * 1.2
            cell.FavoritUserButton.frame.origin.y = cell.frame.height - cell.FavoritUserButton.frame.size.height * 1.2
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            hightChatBattom = cell.ChatButton.frame.size.height
            
            celledit = cell
        }
        
        if indexPath.row == 1 {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "SuperCell1", for: indexPath) as! ProfileTableViewCell
            
            cell.backgroundColor = UIColor.white
            cell.alpha = 0.6
            
            cell.frame.size.height = 10
        
        
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            celledit = cell
            
        
        }
        
        return celledit
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
    


    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
