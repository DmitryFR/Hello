//HTPProfileViewController
//  ViewController.swift
//  Proba
//
//  Created by MacBook on 27.10.16.
//  Copyright © 2016 MacBook. All rights reserved.
//
import UIKit
import Firebase
//import HTPChooseViewController
import VKSdkFramework
@objc class ProbaViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
//    let arrayOfUsers = ["Иванов","Сидоров","Петров"]
//    let arrayOfWork = ["Ремонтирую Iphone","Студент","Инженер физик ядерщик"]
//    let arrayOfComments = ["Принимаю заказы","Ищу работу","Хочу общаться"]
   // let profile : HTPProfileViewController! = nil
    var name : String!
    var rootRef: FIRDatabaseReference!
    var arrayOfUsers = [NSDictionary]()
    var activityIndicator = UIActivityIndicatorView()
    var tok = VKAccessToken()
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.getUsers()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
        self.activityIndicator.frame = CGRect(x: 163, y: 318, width: 200, height: 200)
        self.activityIndicator.startAnimating()
        rootRef = FIRDatabase.database().reference()
        let userRef = self.rootRef.child("users")
        userRef.observe(.value, with: { snapshot in
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot]{
                for snap in snapshots{
                    self.arrayOfUsers.append(snap.value as! NSDictionary)
                }
            self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
            }
            
        })
        
    }
    
    //Указываем количество рядов в секции
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   //     NSLog("%@", self.arrayOfUsers.count)
        return arrayOfUsers.count
    }
    //Создаем функцию создающую ячейки
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let СellID = "Cell" //Соответствие идентификатору
        let cell = tableView.dequeueReusableCell( withIdentifier: СellID, for: indexPath) as! ProbaTableViewCell
        let path = arrayOfUsers[indexPath.row].value(forKey: "photo_100")as!String
        var url:NSURL = NSURL(string: path)!
        var mydata:NSData = NSData(contentsOf: url as URL)!
        
        
        cell.Avatar.image = UIImage(data: mydata as Data)
        cell.Name?.text = arrayOfUsers[indexPath.row].value(forKey: "first_name")as!String
        cell.Work?.text = arrayOfUsers[indexPath.row].value(forKey: "last_name")as! String
      //  cell.Comments?.text = arrayOfUsers[indexPath.row].value(forKey: "")
        
        cell.Avatar.layer.cornerRadius = 33
        cell.Avatar.clipsToBounds = true
        
        
        
        return cell
    }

  override  func viewDidDisappear(_ animated: Bool) {
        self.arrayOfUsers.removeAll()
    }

  //  @IBOutlet weak var AvaProfil: UIImageView!
    
   // @IBOutlet weak var NameProfil: UILabel!
    
    
    
  
        
        //Попытка присвония объектам информации из ячейки
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chosenUser"{
            let indexp = self.tableView.indexPathForSelectedRow as? (NSIndexPath)
            if  let profile = segue.destination as? HTPChooseViewController{
                profile.loggedUser = arrayOfUsers[(indexp?.row)!] as! [AnyHashable : Any]
                profile.tok = self.tok
            }
        }
        
    }
 
    
}



        





