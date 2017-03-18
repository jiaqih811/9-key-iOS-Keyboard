//
//  ComputerViewController.swift
//  9-key
//
//  Created by AlexaLiu on 3/18/17.
//  Copyright © 2017 hjq. All rights reserved.
//

import UIKit
import CoreBluetooth

class ComputerViewController: UIViewController, CBPeripheralManagerDelegate, CBPeripheralDelegate {

    @IBOutlet weak var textField: UITextField!
    
    var peripheralManager: CBPeripheralManager!
    let SERVICE_UUID = CBUUID(string: "2164BBC1-BDC0-4777-AB5A-DB46799DD2BD")
    let service = CBMutableService(type: CBUUID(string: "2164BBC1-BDC0-4777-AB5A-DB46799DD2BD"), primary: true)
    let CHAR_UUID = CBUUID(string: "9331B543-816C-4C0A-8C85-27305551991C")
    let properties: CBCharacteristicProperties = [.notify, .read, .write]
    let permissions: CBAttributePermissions = [.readable]
    let characteristic = CBMutableCharacteristic(
        type: CBUUID(string: "9331B543-816C-4C0A-8C85-27305551991C"),
        properties: [.notify, .read, .write],
        value: nil,
        permissions: [.readable])
    
    override func viewDidLoad() {
        
        self.peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
        
        
        
        super.viewDidLoad()
    // Do any additional setup after loading the view.
    }
    func peripheralManager(peripheral: CBPeripheralManager, didAddService service: CBService, error: NSError?) {
        if let error = error {
            print("peripheral manager error: \(error)")
            return
        }
        
        print("service: \(service)")
    }
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheralManager.state == CBManagerState.poweredOn {
            peripheralManager.add(self.service)
            print("update")
        }
            
        else {
            print("not on")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        if let error = error {
            print("Advertise Failed… error: \(error)")
            return
        }
        print("Advertise Succeeded!")
    }
    
    func peripheralManager(peripheral: CBPeripheralManager, didReceiveReadRequest request: CBATTRequest) {
        if request.characteristic.uuid.isEqual(characteristic.uuid) {
            // Set the correspondent characteristic's value
            // to the request
            request.value = self.characteristic.value
            
            // Respond to the request
            peripheralManager.respond(to: request, withResult: .success)
        }
    }
    
    @IBAction func didTapSend(_ sender: Any) {
        let myString = self.textField.text as String!
        let myNSString = myString as! NSString
        let myNSData = myNSString.data(using: String.Encoding.utf8.rawValue)!
        self.characteristic.value = myNSData
        peripheralManager.updateValue(
            myNSData,
            for: self.characteristic,
            onSubscribedCentrals: nil)
        self.service.characteristics = [self.characteristic]
        let advertisementData = [CBAdvertisementDataLocalNameKey: "Test"]
        peripheralManager.startAdvertising(advertisementData)
    }

    @IBAction func didTapDisconnect(_ sender: Any) {
        peripheralManager.stopAdvertising()
        performSegue(withIdentifier: "BackToSetting", sender: nil)
    }

//    func peripheralManager(peripheral: CBPeripheralManager, didReceiveWriteRequests requests: [CBATTRequest])
//    {
//        for request in requests
//        {
//            if request.characteristic.uuid.isEqual(characteristic.uuid)
//            {
//                // Set the request's value
//                // to the correspondent characteristic
//                characteristic.value = request.value
//            }
//        }
//        peripheralManager.respond(to: requests[0], withResult: .success)
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
