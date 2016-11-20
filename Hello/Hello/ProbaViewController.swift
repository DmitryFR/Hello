//HTPProfileViewController
//  ViewController.swift
//  Proba
//
//  Created by MacBook on 27.10.16.
//  Copyright © 2016 MacBook. All rights reserved.
//
import UIKit
import Firebase


class ProbaViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
//    let arrayOfUsers = ["Иванов","Сидоров","Петров"]
//    let arrayOfWork = ["Ремонтирую Iphone","Студент","Инженер физик ядерщик"]
//    let arrayOfComments = ["Принимаю заказы","Ищу работу","Хочу общаться"]
   // let profile : HTPProfileViewController! = nil
    var name : String!
    var rootRef: FIRDatabaseReference!
    var arrayOfUsers = [NSDictionary]()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.getUsers()
        

    }
    
//    func getUsers(){
//        rootRef = FIRDatabase.database().reference()
//               let userRef = self.rootRef.child("users")
//        userRef.observe(.childAdded, with: { snapshot in
//                        if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot]{
//                            for snap in snapshots{
//                                self.arrayOfUsers.append(snap.value as! NSDictionary)
//                            }
//                        }
//                        
//                    })
//
//         self.tableView.reloadData()
//
//    }
    override func viewWillAppear(_ animated: Bool) {
        //начало ромашки
        rootRef = FIRDatabase.database().reference()
        let userRef = self.rootRef.child("users")
        userRef.observe(.value, with: { snapshot in
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot]{
                for snap in snapshots{
                    self.arrayOfUsers.append(snap.value as! NSDictionary)
                }
            self.tableView.reloadData()
                //конец ромашки
            }
            
        })
        
 
        //self.getUsers()
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


  //  @IBOutlet weak var AvaProfil: UIImageView!
    
   // @IBOutlet weak var NameProfil: UILabel!
    
    
    
  
        
        //Попытка присвония объектам информации из ячейки
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toProfile"{
//            //let indexp = self.tableView.indexPathForSelectedRow as? (NSIndexPath)
//            if  let profile = segue.destination as? HTPChooseProfileViewController{
//                name = arrayOfUsers[(indexp?.row)!]
//        profile.image = name
//            }
//        }
//        
//    }
 
    
}

   
        





