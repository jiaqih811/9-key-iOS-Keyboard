//
//  SettingViewController.swift
//  9-key
//
//  Created by AlexaLiu on 3/30/17.
//  Copyright © 2017 hjq. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

class SettingViewController: UIViewController {

    @IBOutlet weak var InfoLabel: UILabel!
    @IBOutlet weak var ProfInfoLabel: UILabel!
    let URL = "http://35.2.153.195:3000/api/v1/dict/"
    let userDefaults = UserDefaults(suiteName: GROUP_NAME)
    override func viewDidLoad() {
        super.viewDidLoad()
        makeRoundCorners()

        let email = self.userDefaults?.object(forKey: "email") as! String
        let file = self.userDefaults?.object(forKey: "cur_file_name") as! String
        self.InfoLabel.text = "| Logged in as: " + email + " |"
        self.ProfInfoLabel.text = "| Using dict: " + file + " |"
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        
        let email = self.userDefaults?.object(forKey: "email") as! String
        let file = self.userDefaults?.object(forKey: "cur_file_name") as! String
        self.InfoLabel.text = "| Logged in as: " + email + " |"
        self.ProfInfoLabel.text = "| Using dict: " + file + " |"
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
    @IBAction func didTapSignOut(_ sender: Any) {
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
            
            dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: \(signOutError.localizedDescription)")
        }

        self.userDefaults!.set(0, forKey: "isSignedIn")
        self.userDefaults!.synchronize()


    }
    
    @IBAction func didTapSync(_ sender: Any) {
        
        let localURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: GROUP_NAME)
        let userID = self.userDefaults?.object(forKey: "uid") as! String
        
        guard let syncData = UserDefaults.standard.object(forKey: "sync_dict_names") as? NSData else {
            print("'sync_dict_names' not found in UserDefaults")
            return
        }
        
        guard let syncArray = NSKeyedUnarchiver.unarchiveObject(with: syncData as Data) as? [String] else {
            print("Could not unarchive from syncData")
            return
        }

        
        for dict in syncArray {
            print("upload to server " + dict)
            let localDictURL = localURL?.appendingPathComponent(dict).appendingPathExtension("txt")
            Alamofire.upload(
                multipartFormData: { multipartFormData in
                    multipartFormData.append(localDictURL!, withName: "data")
                    multipartFormData.append(dict.data(using: String.Encoding.utf8)!, withName: "profile_name")
                    multipartFormData.append(userID.data(using: String.Encoding.utf8)!, withName: "user")
                
            },
                to: URL,
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.responseJSON { response in
                            debugPrint(response)
                        }
                    case .failure(let encodingError):
                        print(encodingError)
                    }
            }
            )
        }
        
        
    }
    
    func makeRoundCorners() {
        for button in self.view.subviews {
            if button is UIButton {
                (button as! UIButton).backgroundColor = UIColor.white
                button.layer.cornerRadius = 6
                button.layer.masksToBounds = true
                
            }
        }
        
    }
    @IBAction func didTapLayoutSetting(_ sender: Any) {
        performSegue(withIdentifier: "ToLayoutSetting", sender: nil)
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
