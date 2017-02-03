//
//  ViewController.swift
//  nineKeyKeyboard
//
//  Created by hjq on 17/1/31.
//  Copyright © 2017年 hjq. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    var ref: FIRDatabaseReference!
    var output = ""

    @IBOutlet weak var mylabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = FIRDatabase.database().reference()
        self.ref.observe(.value, with: { (snapshot) in
            
            let key  = snapshot.key as String
            let value = snapshot.value as? NSDictionary

            debugPrint("hello")
            debugPrint(key)
            let mytext = value!["testName"] as! String!

            self.mylabel.text = mytext as String!
            self.view.setNeedsDisplay()
            
            
            
        }) { (error) in
            print(error.localizedDescription)
        }

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

