//HTPProfileViewController
//  ViewController.swift
//  Proba
//
//  Created by MacBook on 27.10.16.
//  Copyright © 2016 MacBook. All rights reserved.
//

//import UIKit
//import HTPProfileViewController
/*class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
 }
*/

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let arrayOfUsers = ["Иванов","Сидоров","Петров"]
    let arrayOfWork = ["Ремонтирую Iphone","Студент","Инженер физик ядерщик"]
    let arrayOfComments = ["Принимаю заказы","Ищу работу","Хочу общаться"]
   // let profile : HTPProfileViewController! = nil
    var name : String!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Указываем количество рядов в секции
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfUsers.count
    }
    //Создаем функцию создающую ячейки
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let СellID = "Cell" //Соответствие идентификатору
        let cell = tableView.dequeueReusableCell( withIdentifier: СellID, for: indexPath) as! ProbaTableViewCell
        
       
        
        
        cell.Avatar.image = #imageLiteral(resourceName: "picture.jpg")
        cell.Name?.text = arrayOfUsers[indexPath.row]
        cell.Work?.text = arrayOfWork[indexPath.row]
        cell.Comments?.text = arrayOfComments[indexPath.row]
        
        cell.Avatar.layer.cornerRadius = 33
        cell.Avatar.clipsToBounds = true
        
        
        //Ячейка создана
        
        /*cell.textLabel?.text = arrayOfUsers[indexPath.row]
        //Текст в ячейке
        
        cell.imageView?.image = #imageLiteral(resourceName: "picture.jpg")
        //Картинка в ячейке*/
        
        return cell
    }


  //  @IBOutlet weak var AvaProfil: UIImageView!
    
   // @IBOutlet weak var NameProfil: UILabel!
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
      return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

    }
  
        
        //Попытка присвония объектам информации из ячейки
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toProfile"{
            let indexp = self.tableView.indexPathForSelectedRow as? (NSIndexPath)
            if  let profile = segue.destination as? HTPProfileViewController{
                name = arrayOfUsers[(indexp?.row)!]
        profile.image = name
            }
        }
        
    }
 
    
}

   
        





