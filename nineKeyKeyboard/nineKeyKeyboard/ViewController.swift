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

class ViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    
    var manager: CBCentralManager!
    var peripheral: CBPeripheral!
    
    let BEAN_NAME = UIDevice.current.name
    let BEAN_SCRATCH_UUID = CBUUID(string: UIDevice.current.identifierForVendor!.uuidString)
    
    var ref: FIRDatabaseReference!
    var output = ""

    @IBOutlet weak var mylabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager = CBCentralManager(delegate: self, queue: nil)
        self.ref = FIRDatabase.database().reference()
        self.ref.observe(.value, with: { (snapshot) in
            
            let key  = snapshot.key as String
            let value = snapshot.value as? NSDictionary

            debugPrint("hello")
            debugPrint(key)
//            let mytext = UIDevice.current.identifierForVendor!.uuidString as! String!
//            
//
//            self.mylabel.text = mytext as String!
//            self.view.setNeedsDisplay()
            
            
            
        }) { (error) in
            print(error.localizedDescription)
        }

        // Do any additional setup after loading the view, typically from a nib.
    }

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {

            self.mylabel.text = "Bluetooth available"
            self.view.setNeedsDisplay()
            central.scanForPeripherals(withServices: nil, options: nil)
        } else {
            print("Bluetooth not available.")
        }
    }
    
    func centralManager(
        central: CBCentralManager,
        didDiscoverPeripheral peripheral: CBPeripheral,
        advertisementData: [String : AnyObject],
        RSSI: NSNumber) {
        let device = (advertisementData as NSDictionary)
            .object(forKey: CBAdvertisementDataLocalNameKey)
            as? NSString
        
        if device?.contains(BEAN_NAME) == true {
            self.manager.stopScan()
            
            self.peripheral = peripheral
            self.peripheral.delegate = self
            
            manager.connect(peripheral, options: nil)
        }
    }
    
    func centralManager(
        central: CBCentralManager,
        didConnectPeripheral peripheral: CBPeripheral) {
        peripheral.discoverServices(nil)
    }
    
    func peripheral(
        peripheral: CBPeripheral,
        didDiscoverServices error: NSError?) {
        for service in peripheral.services! {
            let thisService = service as CBService
            
            if service.uuid == BEAN_SCRATCH_UUID {
                peripheral.discoverCharacteristics(
                    nil,
                    for: thisService
                )
            }
        }
    }

}

