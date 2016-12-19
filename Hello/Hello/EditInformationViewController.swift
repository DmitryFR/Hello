//
//  EditInformationViewController.swift
//  Hello
//
//  Created by Дмитрий Фролов on 19.12.16.
//  Copyright © 2016 Дмитрий Фролов. All rights reserved.
//

import UIKit
import Firebase
import VK_ios_sdk

class EditInformationViewController: UIViewController {

    @IBOutlet weak var messgField: UITextField!
    @IBOutlet weak var additionalInfoField: UITextField!
    var currentUser = NSMutableDictionary()
    var rootRef: FIRDatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rootRef = FIRDatabase.database().reference()
        
    }

    @IBAction func changeButtonPressed(_ sender: AnyObject) {
        self.currentUser.setValue(self.messgField.text, forKey: "message")
        self.currentUser.setValue(self.additionalInfoField.text, forKey: "additionalInfo")
        self.rootRef.child("users").updateChildValues([self.currentUser.value(forKey: "id")as! String:self.currentUser])
        self.navigationController?.popViewController(animated: true)
        
    }
    

}
