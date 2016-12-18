//HTPProfileViewController
//  ViewController.swift
//  Proba
//
//  Created by MacBook on 27.10.16.
//  Copyright © 2016 MacBook. All rights reserved.
//
import UIKit
import Firebase
import VK_ios_sdk
import CoreLocation
import CoreBluetooth
@objc class ProbaViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate, CBPeripheralManagerDelegate {
    
//    let arrayOfUsers = ["Иванов","Сидоров","Петров"]
//    let arrayOfWork = ["Ремонтирую Iphone","Студент","Инженер физик ядерщик"]
//    let arrayOfComments = ["Принимаю заказы","Ищу работу","Хочу общаться"]
   // let profile : HTPProfileViewController! = nil
    
    var name : String!
    var rootRef: FIRDatabaseReference!
    var arrayOfUsers = [NSDictionary]()
    var activityIndicator = UIActivityIndicatorView()
    var tok = VKAccessToken()
    var arrayOfBeacons = [CLBeacon]()
    var locManager = CLLocationManager()
    var myBeaconData:NSDictionary!
    var blueManager:CBPeripheralManager!
    var myLocation:CLLocation!
    var fbLon:CLLocationDegrees!
    @IBOutlet weak var tableView: UITableView!
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state == .poweredOn{
            blueManager.startAdvertising(myBeaconData as! [String: AnyObject]!)
        }
        if peripheral.state == .poweredOff{
            blueManager.stopAdvertising()
            //stopLocalBeacon()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        locManager.delegate = self
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.authorizedWhenInUse){
            locManager.requestWhenInUseAuthorization()
        }
        locManager.desiredAccuracy = kCLLocationAccuracyBest //сигнификант
        locManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
     myLocation = locations.last! as CLLocation
        
    }
    
    override func viewWillAppear( _ animated: Bool) {
       
        ////
        // beacon раздача сигнала
        let beaconID = UIDevice.current.identifierForVendor?.uuidString
        let region = CLBeaconRegion(proximityUUID: NSUUID(uuidString: beaconID!) as! UUID, identifier: "Estimotes")
        myBeaconData = region.peripheralData(withMeasuredPower: nil)
        blueManager = CBPeripheralManager(delegate: self, queue: nil, options: nil)
        

        rootRef = FIRDatabase.database().reference()
        let userRef = self.rootRef.child("users")
        //queryOrderByChild - в какой ветви дерева ищем
        //queryEqual - с каким значением сравниваем в ветви
        //observe.value - получаем значения полностью из userRef (но это не точно)
        //observe. childAdded - получаем только одну строчку (но это не точно)????
        
        
                //ПОЛУЧЕНИЕ ПОЛЬЗОВАТЕЛЕЙ СОГЛАСНО ГЕОЛОКАЦИИ
        userRef.observe(.value, with: {snapshot in
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot]{
                for snap in snapshots{
                    let u = snap.value as! NSDictionary
                    self.fbLon = u.value(forKey: "lon") as! CLLocationDegrees //при запуске через эмулятор не может считать локацию, потому что у эмултора нет ни локации ни блютуса
                    let fbLat = u.value(forKey: "lat") as! CLLocationDegrees
                let fbLocation = CLLocation.init(latitude: fbLat, longitude: self.fbLon)
                    let loc = self.myLocation.distance(from: fbLocation)
                    if self.myLocation.distance(from: fbLocation) < 150{
                        self.arrayOfUsers.append(snap.value as! NSDictionary)
                    }
                }
                self.tableView.reloadData()
            }
        
        })
        
    }
    

    // поиск по блютусу если поиск по геолокации не удался
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.arrayOfUsers.removeAll()
        let beaconID = UIDevice.current.identifierForVendor?.uuidString
        let region = CLBeaconRegion(proximityUUID: NSUUID(uuidString: beaconID!) as! UUID, identifier: "Estimotes")
        locManager.startRangingBeacons(in: region)
        rootRef = FIRDatabase.database().reference()
        let userRef = self.rootRef.child("users")

        for beacon in self.arrayOfBeacons{
            
            userRef.queryOrdered(byChild: "beaconID").queryEqual(toValue: beacon.proximityUUID).observe(.value, with: {snapshot in
                if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot]{
                    for snap in snapshots{
                        self.arrayOfUsers.append(snap.value as! NSDictionary)
                    }
                    self.tableView.reloadData()
                   
                   
                }
            })
        }
    }
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        self.arrayOfBeacons = beacons.filter{ $0.proximity != CLProximity.unknown}
        
        print(beacons)
        if (self.arrayOfBeacons.count > 0){
            
        }
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



        





