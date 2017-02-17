//
//  SettingViewController.swift
//  nineKeyKeyboard
//
//  Created by AlexaLiu on 2/17/17.
//  Copyright © 2017 hjq. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var infoLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.infoLabel.text = "Logged in as: " + AppState.sharedInstance.displayName!

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func didTapProfileManage(_ sender: Any) {
        performSegue(withIdentifier: "ToProfileManage", sender: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
