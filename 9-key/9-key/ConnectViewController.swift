//
//  ConnectViewController.swift
//  9-key
//
//  Created by AlexaLiu on 4/4/17.
//  Copyright © 2017 hjq. All rights reserved.
//

import UIKit
import SwiftSocket

class ConnectViewController: UIViewController {
    
    @IBOutlet weak var addrField: UITextField!
    @IBOutlet weak var portField: UITextField!
    @IBOutlet weak var inputField: UITextField!
    
    let uuid = UIDevice.current.identifierForVendor?.uuidString
    var client: TCPClient?
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    @IBAction func didTapConnect(_ sender: Any) {
        self.client = TCPClient(address: addrField.text!, port: Int32(portField.text!)!)
        switch self.client!.connect(timeout: 1) {
        case .success:
            print("connection success")
            switch self.client!.send(string: "Hello from uuid " + uuid! + "\n") {
            case .success:
                print("success send")
//                guard let data = client.read(1024*10) else { return }
//                
//                if let response = String(bytes: data, encoding: .utf8) {
//                    print(response)
//                }
            case .failure(let error):
                print(error)
            }
        case .failure(let error):
            print(error)
        }

    }
    @IBAction func didTapSend(_ sender: Any) {
        
            switch self.client!.send(string: inputField.text! + "\n") {
            case .success:
                print("success send")
            case .failure(let error):
                print(error)
        }

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
