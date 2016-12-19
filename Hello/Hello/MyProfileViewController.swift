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

    

    var navi = UINavigationController()
    var navi2 = UINavigationController()
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
       rootRef = FIRDatabase.database().reference()
        let beaconID = UIDevice.current.identifierForVendor?.uuidString
        let requset:VKRequest = VKRequest(method: "users.get", parameters: [VK_API_ACCESS_TOKEN: self.tok, VK_API_FIELDS: "first_name, last_name, id, photo_400_orig,sex"])
        
        requset.execute(resultBlock: {(response)->Void in
            print (response?.json)
            self.currentUser.setValue((((response?.json as! NSArray).mutableCopy() as! NSMutableArray).firstObject as! NSDictionary).value(forKey: "first_name") as! String, forKey: "first_name")
            self.currentUser.setValue((((response?.json as! NSArray).mutableCopy() as! NSMutableArray).firstObject as! NSDictionary).value(forKey: "last_name") as! String, forKey: "last_name")
            self.currentUser.setValue((((response?.json as! NSArray).mutableCopy() as! NSMutableArray).firstObject as! NSDictionary).value(forKey: "photo_400_orig") as! String?, forKey: "photo_400_orig")
            let num = (((response?.json as! NSArray).mutableCopy() as! NSMutableArray).firstObject as! NSDictionary).value(forKey: "id") as! NSNumber
            self.currentUser.setValue(num.stringValue, forKey: "id")
            self.currentUser.setValue(beaconID, forKey: "beaconID")
            if ((((response?.json as! NSArray).mutableCopy() as! NSMutableArray).firstObject as! NSDictionary).value(forKey: "sex") as! Int == 1){
            self.currentUser.setValue("Ж", forKey: "sex")
            }
            else if((((response?.json as! NSArray).mutableCopy() as! NSMutableArray).firstObject as! NSDictionary).value(forKey: "sex") as! Int == 2){
                self.currentUser.setValue("М", forKey: "sex")
                
            }
            else {self.currentUser.setValue("X", forKey: "sex")}
//            self.currentUser.setValue("nmnmnm", forKey: "additionalInfo")
//            self.currentUser.setValue("lllllll", forKey: "message")
            self.SayMass.text = self.currentUser.value(forKey: "message") as! String?
            self.AboutMe.text = self.currentUser.value(forKey: "additionalInfo") as! String?
            var url:NSURL = NSURL(string: self.currentUser.value(forKey: "photo_400_orig") as! String)!
            var mydata:NSData = NSData(contentsOf: url as URL)!
            
            
            self.BackIm.image = UIImage(data: mydata as Data)

            self.rootRef.child("users").updateChildValues([self.currentUser.value(forKey: "id") as! String:self.currentUser])
            self.tableView.reloadData()
            self.locManager.startUpdatingLocation()
            }, errorBlock: {(error) ->Void in print(error)})
       
        self.locManager.delegate = self
        self.locManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        self.locManager.requestWhenInUseAuthorization()
        
        tableView.backgroundColor = UIColor.clear
        self.cellSize = tableView.frame.size.width
       // self.BackIm.image = im
        
        self.origYIm = self.BackIm.frame.origin.y
        self.tableView.separatorColor = UIColor.clear
        
        let BackBarImage = UIImage (named: "UpBar.png")! as UIImage
        self.navigationController?.navigationBar.setBackgroundImage(BackBarImage, for: .default)
        self.BackView.frame.origin.y = self.tableView.frame.size.width + 62
        self.BackViewY = BackView.frame.origin.y
        
        
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
        userRef.updateChildValues([self.currentUser.value(forKey: "id") as! String:self.currentUser], withCompletionBlock: {(error) in
            print(error)
        })
//        //userRef.updateChildValues([self.currentUser.value(forKey: "id"):self.currentUser], withCompletionBlock: {(error) in
//            print(error)
//        })
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.SayMass.text = self.currentUser.value(forKey: "message") as! String?
        self.AboutMe.text = self.currentUser.value(forKey: "additionalInfo") as! String?
    }
    override func viewWillDisappear(_ animated: Bool) {
        rootRef = FIRDatabase.database().reference()
        let userRef = self.rootRef.child("users")
        self.currentUser["message"] = self.SayMass.text
        self.currentUser["additionalInfo"] = self.AboutMe.text
        userRef.updateChildValues([self.currentUser.value(forKey: "id") as! String:self.currentUser], withCompletionBlock: {(error) in
            print(error)
        })
        
        self.navi = self.tabBarController?.viewControllers![2] as! UINavigationController
        let prof = self.navi.topViewController as! MainMapViewController
        prof.tok = self.tok
        prof.currentUser = self.currentUser
        self.navi2 = self.tabBarController?.viewControllers![1] as! UINavigationController
        let fav = self.navi2.topViewController as! LikeUsersViewController
        fav.tok = self.tok
        fav.currentUser = self.currentUser

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
//            //let nameString = self.currentUser.value(forKey: "first_name")
//            let nameString = "\(self.currentUser.value(forKey: "first_name")) \(self.currentUser.value(forKey: "last_name"))" as! String?
        
            cell.name.text = self.currentUser.value(forKey: "first_name") as! String?
            cell.fam.text = self.currentUser.value(forKey: "last_name")as! String?
            cell.gender.text = self.currentUser.value(forKey: "sex") as! String?
        
            
            
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            celledit = cell
            
            
        }
        
        return celledit
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! EditInformationViewController
        vc.currentUser = self.currentUser
    }
    
}
