//
//  ChatViewController.swift
//  Proba
//
//  Created by MacBook on 12.12.16.
//  Copyright © 2016 MacBook. All rights reserved.
//

import UIKit
import Firebase
import VK_ios_sdk
class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var TextWrite: UITextField!
    @IBOutlet weak var ProbaButton: UIButton!
    var currentUser = NSMutableDictionary()
    var msgArr = NSArray()
    var tok = VKAccessToken()
   
    
    func keyboardWillShow(notification:NSNotification) {
        adjustingHeight(show: true, notification: notification)
    }
    
    func keyboardWillHide(notification:NSNotification) {
        adjustingHeight(show: false, notification: notification)
    }
    
    override func viewDidLoad() {
        
        
        self.tableView.transform = CGAffineTransform(rotationAngle: CGFloat( M_PI ))
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        self.tableView.separatorColor = UIColor.clear
        
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        let idd = self.currentUser.value(forKey: "id") as! String
        let requset:VKRequest = VKRequest(method: "messages.getHistory", parameters: [VK_API_USER_ID: idd, VK_API_COUNT: 20])
        requset.execute(resultBlock: {(response)->Void in
            print (response?.json)
           // self.msgArr = (((response?.json as! NSArray).mutableCopy() as! NSMutableArray).firstObject as! NSDictionary).value(forKey: "items") as! NSMutableArray
            self.msgArr = (response?.json as! NSDictionary).value(forKey: "items")as! NSArray
            self.tableView.reloadData()
            }, errorBlock: {(error) ->Void in print(error)})
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       // self.view.endEditing(true)
        TextWrite.resignFirstResponder()
        super.touchesBegan( touches, with: event)
    }
    
    
    
    func adjustingHeight(show:Bool, notification:NSNotification) {
        // 1
        var userInfo = notification.userInfo!
        // 2
        let keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        // 3
        let animationDurarion = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        // 4
        let changeInHeight = (keyboardFrame.height + 30 - 91) * (show ? 1 : -1)
        //5
        UIView.animate(withDuration: animationDurarion, animations: { () -> Void in
            self.TextWrite.frame.origin.y -= changeInHeight
            self.tableView.frame.origin.y -= changeInHeight
        })
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.msgArr.count
    }

//    @IBAction func backBtnPressed(_ sender: AnyObject) {
//        self.navigationController?.popViewController(animated: true)
//    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatViewCell
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        if(((self.msgArr[indexPath.row]as! NSDictionary).value(forKey: "from_id")as! NSNumber).stringValue==self.currentUser.value(forKey: "id")as! String){
        cell.ChatMess.text = (self.msgArr[indexPath.row]as! NSDictionary).value(forKey: "body") as! String?
        cell.ChatMess.transform = CGAffineTransform(rotationAngle: CGFloat( M_PI ))
        cell.ChatMess.textAlignment = .right
        }
        else{
            cell.ChatMess.text = (self.msgArr[indexPath.row]as! NSDictionary).value(forKey: "body") as! String?
            cell.ChatMess.transform = CGAffineTransform(rotationAngle: CGFloat( M_PI ))
            cell.ChatMess.textAlignment = .left
        }
        return cell
    }
    

    @IBAction func sendMssg(_ sender: AnyObject) {
        TextWrite.resignFirstResponder()
        let idd = self.currentUser.value(forKey: "id") as! String
        
       
        let request:VKRequest = VKRequest(method: "messages.send", parameters: [VK_API_ACCESS_TOKEN:self.tok, VK_API_USER_ID: idd, VK_API_MESSAGE: self.TextWrite.text!])
        request.execute(resultBlock: {(response)->Void in
            print (response?.json)
            }, errorBlock: {(error) ->Void in print(error)})
    self.TextWrite.text  = ""
        
        let requset:VKRequest = VKRequest(method: "messages.getHistory", parameters: [VK_API_USER_ID: idd, VK_API_COUNT: 20])
        requset.execute(resultBlock: {(response)->Void in
            print (response?.json)
            self.msgArr = (response?.json as! NSDictionary).value(forKey: "items")as! NSArray
            self.tableView.reloadData()
            }, errorBlock: {(error) ->Void in print(error)})
    
    }
    
    
}
