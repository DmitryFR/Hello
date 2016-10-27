//
//  HTPProfileViewController.swift
//  Proba
//
//  Created by MacBook on 27.10.16.
//  Copyright © 2016 MacBook. All rights reserved.
//

import UIKit

class HTPProfileViewController: UIViewController {
    var image:String! 

    override func viewDidLoad() {
        super.viewDidLoad()

        self.profileName.text = image
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var profileName: UILabel!

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
