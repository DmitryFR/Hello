//
//  LikeUsersViewController.swift
//  Proba
//
//  Created by MacBook on 12.12.16.
//  Copyright © 2016 MacBook. All rights reserved.
//

import UIKit
import VK_ios_sdk
class LikeUsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var imageBack: UIImageView!
    
    
    var tok = VKAccessToken()
    
    let arreyOfColorBorder = [UIColor.green,UIColor.darkGray,UIColor.brown,UIColor.black,UIColor.red]
    let arrayOfUsers = ["Петр Иванов","Владислав Сидоров","Ирина Петрова"]
    let arrayOfWork = ["Ремонтирую Iphone","Студент","Инженер физик ядерщик"]
    let arrayOfComments = ["Принимаю заказы","Ищу работу","Хочу общаться"]
    let arreyOfstatus = ["Открыт для общения","Готов к общению по проф. виду деятельности","Не очень хочу общаться","Не хочу общаться","Лучше не беспокоить"]
    var name : String!
    
    let comment = ("Иду на концерт группы Грибы, друзья не пошли! Есть 2 лишних билета, отдам ДАРОМ!")
    
    
    
    
    var OrigY:CGFloat = 0
    
    override func viewDidLoad() {
        
        self.tableView.backgroundColor = UIColor.clear
        //self.BackImage.image = #imageLiteral(resourceName: "Kosmos.jpg")
        let BackBarImage = UIImage (named: "UpBar.png")! as UIImage
        self.navigationController?.navigationBar.setBackgroundImage(BackBarImage, for: .default)
        self.tableView.separatorColor = UIColor.clear
        self.OrigY = self.imageBack.frame.origin.y
        
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    var ContentIndex :CGFloat = 0
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.ContentIndex = tableView.contentOffset.y
        var ContentSize = self.tableView.contentSize.height
        //  let h = self.imageBack.frame.size.height
        self.imageBack.frame.origin.y = self.OrigY - 0.9 * ((self.imageBack.frame.size.height-self.tableView.frame.size.height) * ContentIndex / ContentSize)
    }
    
    
    
    
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayOfUsers.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let СellID = "CellUser" //Соответствие идентификатору
        let cell = tableView.dequeueReusableCell( withIdentifier: СellID, for: indexPath) as! UsersTableViewCell
        let statusInetificator = Int (arc4random_uniform(5))
        cell.AvatarUser?.image = #imageLiteral(resourceName: "Tramp.jpg")
        cell.NameUser?.text = arrayOfUsers[indexPath.row]
        cell.StatusUser?.text = arreyOfstatus[statusInetificator]
        cell.ComentUser?.text = arrayOfComments[indexPath.row]
        cell.AvatarUser.frame.size.height = cell.AvatarUser.frame.size.width
        cell.AvatarUser?.layer.cornerRadius = (cell.AvatarUser.frame.size.height / 2)
        cell.AvatarUser?.clipsToBounds = true
        //cell.AvatarUser?.layer.borderWidth = 5
        cell.AvatarUser?.layer.borderColor = arreyOfColorBorder[statusInetificator].cgColor
        // cell.AvatarUser?.layer.borderWidth = 0.8
        cell.StatusImage?.layer.cornerRadius = 10
        cell.StatusImage?.backgroundColor = arreyOfColorBorder[statusInetificator]
        cell.ComentUser?.text = comment
        cell.BackGroundUserImage.layer.cornerRadius = 16
        cell.BackGroundUserImage.layer.borderWidth = 1
        cell.BackGroundUserImage.layer.borderColor = UIColor.white.cgColor
        cell.BackGroundUserImage1.layer.cornerRadius = 16
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        
        cell.backgroundColor = UIColor.clear
        cell.backgroundView = UIImageView (image: #imageLiteral(resourceName: "Bar2.png"))
        cell.backgroundView?.alpha = 0
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toLikeProfileUser"{
            let indexp = self.tableView.indexPathForSelectedRow as? (NSIndexPath)
            if  let profile = segue.destination as? ProfileTableFirstVersion {
                
                profile.fioo = arrayOfUsers[(indexp?.row)!]
                profile.com = arrayOfComments[(indexp?.row)!]
                profile.im = #imageLiteral(resourceName: "Tramp.jpg")
            }
        }
        
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
