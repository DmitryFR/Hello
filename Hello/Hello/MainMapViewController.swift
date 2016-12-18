//
//  MainMapViewController.swift
//  Hello
//
//  Created by Дмитрий Фролов on 18.12.16.
//  Copyright © 2016 Дмитрий Фролов. All rights reserved.
//

import UIKit
import Firebase
import VK_ios_sdk
import CoreLocation
import CoreBluetooth
import MapKit

class MainMapViewController: UIViewController, CLLocationManagerDelegate, CBPeripheralManagerDelegate, MKMapViewDelegate{
    var name : String!
    var rootRef: FIRDatabaseReference!
    var arrayOfUsers = [NSDictionary]()
    
    var tok = VKAccessToken()
    var arrayOfBeacons = [CLBeacon]()
    var locManager = CLLocationManager()
    var myBeaconData:NSDictionary!
    var blueManager:CBPeripheralManager!
    var myLocation:CLLocation!
    var fbLon:CLLocationDegrees!
    var arrayOfPins = NSArray()
    var navi = UINavigationController()
    var navi2 = UINavigationController()
    var currentUser=NSDictionary()

    
    @IBOutlet weak var mapView: MKMapView!
    
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
        self.mapView.delegate = self
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.authorizedWhenInUse){
            locManager.requestWhenInUseAuthorization()
        }
        locManager.desiredAccuracy = kCLLocationAccuracyBest //сигнификант
        locManager.startUpdatingLocation()

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        myLocation = locations.last! as CLLocation
        
    }
    //передача вк токена на другие вкладки таб бара
    override func viewWillDisappear(_ animated: Bool) {
        self.navi = self.tabBarController?.viewControllers![1] as! UINavigationController
        let prof = self.navi.topViewController as! MyProfileViewController
        prof.tok = self.tok
        self.navi2 = self.tabBarController?.viewControllers![2] as! UINavigationController
        let fav = self.navi2.topViewController as! LikeUsersViewController
        fav.tok = self.tok
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
                    //let loc = self.myLocation.distance(from: fbLocation)
                    if self.myLocation.distance(from: fbLocation) < 150{
                        self.arrayOfUsers.append(snap.value as! NSDictionary)
                    }
                }
            //установка пина
                self.mapView.setRegion(MKCoordinateRegionMake(CLLocationCoordinate2DMake(self.myLocation.coordinate.latitude, self.myLocation.coordinate.longitude), MKCoordinateSpanMake(0.05, 0.05)), animated: true)
                for usr in self.arrayOfUsers{
                    let locationPinCoord = CLLocationCoordinate2DMake(usr.value(forKey: "lat") as! CLLocationDegrees, usr.value(forKey: "lon") as! CLLocationDegrees)
                    let annotation = MapPin()
                    annotation.title = usr.value(forKey: "first_name") as! String?
                    annotation.subtitle = usr.value(forKey: "last_name") as! String?
                    annotation.setCoordinate(newCoord: locationPinCoord)
                    self.arrayOfPins.adding(annotation)
                    
                }
            self.mapView.addAnnotations(self.arrayOfPins as! [MKAnnotation])
            }
            
        })
        
    }
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
    
    
    override  func viewDidDisappear(_ animated: Bool) {
        self.arrayOfUsers.removeAll()
    }
    
    
    //кастомный пин на карте
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MapPin{
            let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "mapPin")
            pinAnnotationView.canShowCallout = true
            pinAnnotationView.animatesDrop = true
            pinAnnotationView.pinColor = .purple
            
            let infoButton = UIButton(type: .custom) as UIButton
            infoButton.frame.size.width = 44
            infoButton.frame.size.height = 44
            infoButton.setImage(UIImage(named: "Info-48"), for: .normal)
            pinAnnotationView.leftCalloutAccessoryView = infoButton
            return pinAnnotationView
        }
        return nil
    }
    
// нажатие на кнопку на пине на карте
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        self.performSegue(withIdentifier: "ChosenUser", sender: self)
    }
    
    
}
