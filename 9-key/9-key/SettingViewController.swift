//
//  SettingViewController.swift
//  9-key
//
//  Created by AlexaLiu on 3/30/17.
//  Copyright © 2017 hjq. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var InfoLabel: UILabel!
    @IBOutlet weak var ProfInfoLabel: UILabel!
    
    let userDefaults = UserDefaults(suiteName: GROUP_NAME)
    override func viewDidLoad() {
        super.viewDidLoad()

        let email = self.userDefaults?.object(forKey: "email") as! String
        let file = self.userDefaults?.object(forKey: "cur_file_name") as! String
        self.InfoLabel.text = "Logged in as: " + email
        self.ProfInfoLabel.text = "Using dict: " + file
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        
        let email = self.userDefaults?.object(forKey: "email") as! String
        let file = self.userDefaults?.object(forKey: "cur_file_name") as! String
        self.InfoLabel.text = "Logged in as: " + email
        self.ProfInfoLabel.text = "Using dict: " + file
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapMyProf(_ sender: Any) {
        performSegue(withIdentifier: "ToProfileManage", sender: nil)
    }
    @IBAction func didTapSysProf(_ sender: Any) {
        performSegue(withIdentifier: "ToSysProfs", sender: nil)
    }

    @IBAction func didTapConnectComputer(_ sender: Any) {
        performSegue(withIdentifier: "ToComputerConnection", sender: nil)
    }
    @IBAction func didTapButton(_ sender: Any) {
        performSegue(withIdentifier: "ToConnect", sender: nil)
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
