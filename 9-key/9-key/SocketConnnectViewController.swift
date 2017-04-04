//
//  SocketConnnectViewController.swift
//  9-key
//
//  Created by AlexaLiu on 3/30/17.
//  Copyright © 2017 hjq. All rights reserved.
//

import UIKit
import SwiftSocket
import Foundation

class SocketConnnectViewController: UIViewController {
    
    @IBOutlet weak var addrField: UITextField!
    @IBOutlet weak var portField: UITextField!
    @IBOutlet weak var contentField: UITextField!
//    var uuid = UIDevice.current.identifierForVendor?.uuidString
    var addr = ""
    var port = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapConnectToServer(_ sender: Any) {
//        self.addr = addrField.text!
//        self.port = Int(portField.text!)!
//        let client = TCPClient(address: addr, port: Int32(port))
//        switch client.connect(timeout: 1) {
//        case .success:
//            switch client.send(string: "Hello from uuid " + uuid! ) {
//            case .success:
//                guard let data = client.read(1024*10) else { return }
//                
//                if let response = String(bytes: data, encoding: .utf8) {
//                    print(response)
//                }
//            case .failure(let error):
//                print(error)
//            }
//        case .failure(let error):
//            print(error)
//        }
    }

    @IBAction func didTapSendInput(_ sender: Any) {
//        let client = TCPClient(address: addr, port: Int32(port))
//        switch client.connect(timeout: 1) {
//        case .success:
//            switch client.send(string: "uuid " + uuid! + " input: " + contentField.text!) {
//            case .success:
//                guard let data = client.read(1024*10) else { return }
//                
//                if let response = String(bytes: data, encoding: .utf8) {
//                    print(response)
//                }
//            case .failure(let error):
//                print(error)
//            }
//        case .failure(let error):
//            print(error)
//        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
