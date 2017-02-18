//
//  ViewController.swift
//  nineKeyKeyboard
//
//  Created by hjq on 17/1/31.
//  Copyright © 2017年 hjq. All rights reserved.
//

import UIKit
import Firebase
import CoreBluetooth

class ViewController: UIViewController  /*, CBCentralManagerDelegate, CBPeripheralDelegate */ {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
//    var manager: CBCentralManager!
//    var peripheral: CBPeripheral!
//    
//    let BEAN_NAME = UIDevice.current.name
//    let BEAN_SCRATCH_UUID = CBUUID(string: UIDevice.current.identifierForVendor!.uuidString)
    
    var ref: FIRDatabaseReference!
    var storageRef: FIRStorageReference!
    var output = ""

    var uid: String = ""

    @IBOutlet weak var mylabel: UILabel!
    @IBOutlet weak var unLabel: UILabel!
    @IBOutlet weak var pwLabel: UILabel!
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
//        manager = CBCentralManager(delegate: self, queue: nil)
        self.welcomeLabel.text = "Keyboard Setting.\n Please Sign In/Up."
        self.ref = FIRDatabase.database().reference()
        storageRef = FIRStorage.storage().reference()
        let defaultPath = storageRef.child("system_default.txt")
        // Create local filesystem URL
        // Download to the local filesystem
        
        let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let localDictURL = DocumentDirURL.appendingPathComponent("system_default").appendingPathExtension("txt")
        let downloadTask = defaultPath.write(toFile: localDictURL) { url, error in
            if let error = error {
                // Uh-oh, an error occurred!
                print("error")
            } else {
                print("success")
                // Local file URL for "images/island.jpg" is returned
            }
        }
        
//        self.ref.observe(.value, with: { (snapshot) in
//            
//            let key  = snapshot.key as String
//            let value = snapshot.value as? NSDictionary
//
//            debugPrint("hello")
//            debugPrint(key)
////            let mytext = UIDevice.current.identifierForVendor!.uuidString as! String!
////            
////
////            self.mylabel.text = mytext as String!
////            self.view.setNeedsDisplay()
//            
//            
//            
//        }) { (error) in
//            print(error.localizedDescription)
//        }

        // Do any additional setup after loading the view, typically from a nib.
    }
    

    
    @IBAction func signInButton(_ sender: Any) {
        print(username.text)
        print(password.text)
        // Sign In with credentials.
        guard let email = username.text, let password = password.text else { return }
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                self.showAlert(message: error.localizedDescription)
                
                print(error.localizedDescription)
                return
            }
            self.signedIn(user!)
        }

    }
    @IBAction func SignUpButton(_ sender: Any) {
        guard let email = username.text, let password = password.text else { return }
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                self.showAlert(message: error.localizedDescription)
                print(error.localizedDescription)
                return
            }
            
            //create initial profile
            self.uid = user!.uid
            self.ref.child("users").child(self.uid).setValue(["username": email])
            self.ref.child("users").child(self.uid).child("profiles").child("system_default").setValue("system_default.txt")
        }

    }

//    func centralManagerDidUpdateState(_ central: CBCentralManager) {
//        if central.state == .poweredOn {
//
//            self.mylabel.text = "Bluetooth available"
//            self.view.setNeedsDisplay()
//            central.scanForPeripherals(withServices: nil, options: nil)
//        } else {
//            print("Bluetooth not available.")
//        }
//    }
    
    func signedIn(_ user: FIRUser?) {
        MeasurementHelper.sendLoginEvent()
        
        AppState.sharedInstance.displayName = user?.email
        AppState.sharedInstance.signedIn = true
        AppState.sharedInstance.userID = user?.uid
        let notificationName = Notification.Name(rawValue: "onSignInCompleted")
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: nil)
        performSegue(withIdentifier: "ToNavigationControl", sender: nil)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

//    
//    func centralManager(
//        central: CBCentralManager,
//        didDiscoverPeripheral peripheral: CBPeripheral,
//        advertisementData: [String : AnyObject],
//        RSSI: NSNumber) {
//        let device = (advertisementData as NSDictionary)
//            .object(forKey: CBAdvertisementDataLocalNameKey)
//            as? NSString
//        
//        if device?.contains(BEAN_NAME) == true {
//            self.manager.stopScan()
//            
//            self.peripheral = peripheral
//            self.peripheral.delegate = self
//            
//            manager.connect(peripheral, options: nil)
//        }
//    }
//    
//    func centralManager(
//        central: CBCentralManager,
//        didConnectPeripheral peripheral: CBPeripheral) {
//        peripheral.discoverServices(nil)
//    }
//    
//    func peripheral(
//        peripheral: CBPeripheral,
//        didDiscoverServices error: NSError?) {
//        for service in peripheral.services! {
//            let thisService = service as CBService
//            
//            if service.uuid == BEAN_SCRATCH_UUID {
//                peripheral.discoverCharacteristics(
//                    nil,
//                    for: thisService
//                )
//            }
//        }
//    }

}

