//
//  ViewController.swift
//  9-key
//
//  Created by hjq on 17/2/17.
//  Copyright © 2017年 hjq. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var ref: FIRDatabaseReference!
    var storageRef: FIRStorageReference!
    var output = ""
    var localDefaultDictURL: URL!
    
    var uid: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = FIRDatabase.database().reference()
        self.storageRef = FIRStorage.storage().reference()
        let defaultPath = storageRef.child("System").child("small.txt")
//        let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let DocumentDirURL = Bundle.main.bundleURL
        self.localDefaultDictURL = DocumentDirURL.appendingPathComponent("system_default").appendingPathExtension("txt")
        let filepath1 = Bundle.main.path(forResource: "words", ofType: "txt")
        print(filepath1)
        var userDefaults = UserDefaults(suiteName: "group.9-key-proj")
        userDefaults!.set("user12345", forKey: "userId")
        userDefaults!.synchronize()
        let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.9-key-proj")
        self.localDefaultDictURL = url?.appendingPathComponent("system_default").appendingPathExtension("txt")

//        print(Bundle.main.resourcePath)
//        if Globals.AppState_dictFileName == "" {
//            Globals.AppState_dictFileName = "system_default.txt"
//        }
//        Globals.AppState_dictFilePath = DocumentDirURL.appendingPathComponent(Globals.AppState_dictFileName).path
//        print(Globals.AppState_dictFilePath)
//        self.localDefaultDictURL = NSURL(string: DocumentDirURL) as URL!
        let downloadTask = defaultPath.write(toFile: self.localDefaultDictURL) { url, error in
            if let error = error {
                print("error")
            } else {
                print("success")
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
            self.ref.child("users").child(user!.uid).child("profiles").child("system_default").setValue("system_default.txt")
            let defaultRef = self.storageRef.child(user!.uid).child("system_default.txt")
            let uploadTask = defaultRef.putFile(self.localDefaultDictURL, metadata: nil) { metadata, error in
                if let error = error {
                    print("Uh-oh, an error occurred!")
                } else {
                    print("seccess")
                    // Metadata contains file metadata such as size, content-type, and download URL.
                    let downloadURL = metadata!.downloadURL()
                }
            }

        }

    }
    func signedIn(_ user: FIRUser?) {
        MeasurementHelper.sendLoginEvent()
        
        Globals.AppState_displayName = (user?.email)!
        Globals.AppState_signedIn = true
        Globals.AppState_userID = (user?.uid)!
        let notificationName = Notification.Name(rawValue: "onSignInCompleted")
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: nil)
//        performSegue(withIdentifier: "ToNavigationControl", sender: nil)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}

