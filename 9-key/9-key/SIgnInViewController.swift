//
//  ViewController.swift
//  9-key
//
//  Created by hjq on 17/2/17.
//  Copyright © 2017年 hjq. All rights reserved.
//

import UIKit
import Firebase
import Foundation

class SignInViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var inButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    var ref: FIRDatabaseReference!
    var storageRef: FIRStorageReference!
    var output = ""
    var localDefaultDictURL: URL!
    
    var uid: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inButton.layer.cornerRadius = 2
        signUpButton.layer.cornerRadius = 2
        self.ref = FIRDatabase.database().reference()
        self.storageRef = FIRStorage.storage().reference()
        
        
        var userDefaults = UserDefaults(suiteName: "group.9-key-proj")
        if (userDefaults?.object(forKey: "cur_file_name") == nil) {
            userDefaults!.set("default.txt", forKey: "cur_file_name")
        }
        let a = userDefaults?.object(forKey: "cur_file_name") as! String
        if (userDefaults?.object(forKey: "cur_query_name") == nil) {
            userDefaults!.set("", forKey: "cur_query_name")
        }
        let b = userDefaults?.object(forKey: "cur_query_name") as! String
        if (userDefaults?.object(forKey: "isSignedIn") == nil) {
            userDefaults!.set(0, forKey: "isSignedIn")
        }
//        if (userDefaults?.object(forKey: "dictFileNameArray") == nil) {
//            userDefaults!.set(["default.txt"], forKey: "dictFileNameArray")
//        }
        userDefaults!.synchronize()
        let defaultPath = storageRef.child("System").child("default.txt")
        let localURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.9-key-proj")
        self.localDefaultDictURL = localURL?.appendingPathComponent("default").appendingPathExtension("txt")
        if FileManager.default.fileExists(atPath: self.localDefaultDictURL.path) {
            print("default already exists")
        } else {
            let downloadTask = defaultPath.write(toFile: self.localDefaultDictURL) { url, error in
                if let error = error {
                    print("error")
                } else {
                    print("success")
//                    let dictData = NSKeyedArchiver.archivedData(withRootObject: DictionaryQuery(customMap: arr, fileName: self.localDefaultDictURL.path))
//                    userDefaults!.set(dictData, forKey: "default.txt")

                }
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didTapSignIn(_ sender: Any) {
        guard let email = self.emailField.text, let password = self.passwordField.text else { return }
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
        guard let email = self.emailField.text, let password = self.passwordField.text else { return }
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                self.showAlert(message: error.localizedDescription)
                print(error.localizedDescription)
                return
            }
            self.ref.child("users").child(user!.uid).setValue(["username": email])
            self.ref.child("users").child(user!.uid).child("profiles").child("default").setValue("default.txt")
            let defaultRef = self.storageRef.child(user!.uid).child("default.txt")
            let uploadTask = defaultRef.putFile(self.localDefaultDictURL, metadata: nil) { metadata, error in
                if let error = error {
                    print("Uh-oh, an error occurred!")
                } else {
                    print("seccess")
                    // Metadata contains file metadata such as size, content-type, and download URL.
                    let downloadURL = metadata!.downloadURL()
                }
            }
//            self.signedIn(user)

        }

    }
    func signedIn(_ user: FIRUser?) {
        MeasurementHelper.sendLoginEvent()
        var userDefaults = UserDefaults(suiteName: "group.9-key-proj")
        userDefaults!.set(user?.email, forKey: "email")
        userDefaults!.set(user?.uid, forKey: "uid")
        userDefaults!.set(1, forKey: "isSignedIn")
        userDefaults!.synchronize()
        let notificationName = Notification.Name(rawValue: "onSignInCompleted")
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: nil)
        performSegue(withIdentifier: "ToNavigationControl", sender: nil)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}

