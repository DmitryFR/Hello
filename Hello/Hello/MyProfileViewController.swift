//
//  MyProfileViewController.swift
//  Proba
//
//  Created by MacBook on 14.12.16.
//  Copyright © 2016 MacBook. All rights reserved.
//

import UIKit
import VK_ios_sdk
import Firebase
import CoreLocation
class MyProfileViewController:   UIViewController,  UITableViewDataSource, UITableViewDelegate,CLLocationManagerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var BackIm: UIImageView!
    
    @IBOutlet weak var BackGroundImage: UIImageView!
    
    @IBOutlet weak var BackView: UIView!
    @IBOutlet weak var Status: UILabel!
    @IBOutlet weak var SayMass: UILabel!
    @IBOutlet weak var AboutMe: UILabel!

    

    
    var BackViewY : CGFloat!
    var locManager = CLLocationManager()
    var im: UIImage = #imageLiteral(resourceName: "Tramp.jpg")
    var fioo : String!
    var com : String!
    var origYIm : CGFloat!
    var contentSize: CGFloat!
    var cellSize: CGFloat!
    var AlphaUpFocus: Int = 0
    var tok = VKAccessToken()
    var currentUser = NSMutableDictionary()
    var rootRef: FIRDatabaseReference!
    var lat:CLLocationDegrees = 0.0
    var lon:CLLocationDegrees = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var gUsr = getUser()
        self.currentUser = gUsr.getUserVK(self.tok)

//        requset.execute(resultBlock: {(response)->Void in
//            print (response?.json)
//            
//            }, errorBlock: {(error) ->Void in print(error)})
                 self.locManager.delegate = self
        self.locManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locManager.requestWhenInUseAuthorization()
        self.locManager.startUpdatingLocation()
        tableView.backgroundColor = UIColor.clear
        self.cellSize = tableView.frame.size.width
        self.BackIm.image = im
        self.origYIm = self.BackIm.frame.origin.y
        self.tableView.separatorColor = UIColor.clear
        
        let BackBarImage = UIImage (named: "UpBar.png")! as UIImage
        self.navigationController?.navigationBar.setBackgroundImage(BackBarImage, for: .default)
        self.BackView.frame.origin.y = self.tableView.frame.size.width + 62
        self.BackViewY = BackView.frame.origin.y
        
        self.SayMass.text = self.currentUser.value(forKey: "message") as! String?
        self.AboutMe.text = self.currentUser.value(forKey: "additionalInfo") as! String?
        //Получение информации вк
        //let request:VKRequest = VKRequest(method: "users.get", parameters: ["fields":"first_name, last_name, uid, photo_400_orig,sex"])
       
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let myLoc = locations.last! as CLLocation
        self.lat = myLoc.coordinate.latitude
        self.lon = myLoc.coordinate.longitude
        
        //добавить добавление в базу коорд
        self.currentUser["lat"] = self.lat
        self.currentUser["lon"] = self.lon
        rootRef = FIRDatabase.database().reference()
        let userRef = self.rootRef.child("users")
        print ("OBNOVLENIE")
        userRef.child(self.currentUser.value(forKey: "id") as! String).setValue(["lat":self.lat])
        userRef.child(self.currentUser.value(forKey: "id") as! String).setValue(["lon":self.lon])
//        //userRef.updateChildValues([self.currentUser.value(forKey: "id"):self.currentUser], withCompletionBlock: {(error) in
//            print(error)
//        })
        

    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        rootRef = FIRDatabase.database().reference()
        let userRef = self.rootRef.child("users")
        self.currentUser["message"] = self.SayMass.text
        self.currentUser["additionalInfo"] = self.AboutMe.text
        userRef.updateChildValues([self.currentUser.value(forKey: "id") as! AnyHashable:self.currentUser], withCompletionBlock: {(error) in
            print(error)
        })
        

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
            BackView.frame.origin.y = self.BackViewY - scrollPosition

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
            
           
            
            
            cell.WrireButtom.layer.cornerRadius = cell.WrireButtom.frame.size.height / 2
            cell.WrireButtom.layer.borderWidth = 1
            cell.WrireButtom.layer.borderColor = UIColor.white.cgColor

            
            celledit = cell
        }
        
        if indexPath.row == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SuperCell1", for: indexPath) as! ProfileTableViewCell
            
            cell.backgroundColor = UIColor.clear
            cell.alpha = 0.6
            
            cell.frame.size.height = 10
            let nameString = self.currentUser.value(forKey: "first_name")
//            let nameString = String(format: "%@ %@", (self.currentUser.value(forKey: "first_name") as! String?)!,(self.currentUser.value(forKey: "last_name") as! String?)!)
            cell.name.text = nameString as! String?
            cell.gender.text = self.currentUser.value(forKey: "gender") as! String?
        
            
            
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            celledit = cell
            
            
        }
        
        return celledit
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
    
    
    
    
}
