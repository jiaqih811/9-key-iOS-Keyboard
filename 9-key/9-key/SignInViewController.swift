//
//  SignInViewController.swift
//  9-key
//
//  Created by AlexaLiu on 3/30/17.
//  Copyright © 2017 hjq. All rights reserved.
//

import UIKit
import Firebase

let GROUP_NAME = "group.9-key"



class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!
    let userDefaults = UserDefaults(suiteName: GROUP_NAME)
    var ref: FIRDatabaseReference!
//    var storageRef: FIRStorageReference!
//    var localURL: URL!

    override func viewDidLoad() {
        self.ref = FIRDatabase.database().reference()
//        self.storageRef = FIRStorage.storage().reference()
//        self.localURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: GROUP_NAME)
        makeRoundCorners()
        if (self.userDefaults?.object(forKey: "cur_file_name") == nil) {
            self.userDefaults!.set("default.txt", forKey: "cur_file_name")
        }
        if (self.userDefaults?.object(forKey: "cur_query_name") == nil) {
            self.userDefaults!.set("NIL", forKey: "cur_query_name")
        }
        if (self.userDefaults?.object(forKey: "isSignedIn") == nil) {
            self.userDefaults!.set(0, forKey: "isSignedIn")
        }
        if (self.userDefaults?.object(forKey: "sync_dict_names") == nil) {
            var syncArray: [String] = ["default"]
            let psyncData = NSKeyedArchiver.archivedData(withRootObject: syncArray)
            UserDefaults.standard.set(psyncData, forKey: "sync_dict_names")
        }
        self.userDefaults!.synchronize()
        downloadDict(nil, "default", false)
        let isSignedIn = self.userDefaults?.object(forKey: "isSignedIn") as! Int
        if (isSignedIn == 1) {
            let email = self.userDefaults?.object(forKey: "email") as! String
            let password = self.userDefaults?.object(forKey: "password") as! String
            FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
                if let error = error {
                    self.showAlert(message: error.localizedDescription)
                    print(error.localizedDescription)
                    return
                }
                self.signedIn(user!)
            }
        }
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapSignIn(_ sender: Any) {
        guard let email = self.emailTextField.text, let password = self.passwordTextField.text else { return }
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                self.showAlert(message: error.localizedDescription)
                print(error.localizedDescription)
                return
            }
            self.signedIn(user!)
        }
    }

    @IBAction func didTapSignUp(_ sender: Any) {
        guard let email = self.emailTextField.text, let password = self.passwordTextField.text else { return }
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                self.showAlert(message: error.localizedDescription)
                print(error.localizedDescription)
                return
            }
            self.ref.child("users").child(user!.uid).setValue(["username": email])
            self.ref.child("users").child(user!.uid).child("profiles").child("default").setValue("default.txt")
                        self.showAlert(message: "Successfully created account.")
            uploadUserDict(user?.uid, "default")
//            self.signedIn(user)
        }
    }
    
    func signedIn(_ user: FIRUser?) {
        MeasurementHelper.sendLoginEvent()
        self.userDefaults!.set(user?.email, forKey: "email")
        self.userDefaults!.set(self.passwordTextField.text, forKey: "password")
        self.userDefaults!.set(user?.uid, forKey: "uid")
        self.userDefaults!.set(1, forKey: "isSignedIn")
        self.userDefaults!.synchronize()
        let notificationName = Notification.Name(rawValue: "onSignInCompleted")
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: nil)
        performSegue(withIdentifier: "ToNavigationControl", sender: nil)
    }
    func showAlert(message: String) {
        let alert = UIAlertController(title: "HaHa", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
