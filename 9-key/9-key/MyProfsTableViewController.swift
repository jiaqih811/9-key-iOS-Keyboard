//
//  MyProfsTableViewController.swift
//  9-key
//
//  Created by AlexaLiu on 2/19/17.
//  Copyright © 2017 hjq. All rights reserved.
//

import UIKit
import Firebase
import Foundation

class MyProfsTableViewController: UITableViewController {

    var ref: FIRDatabaseReference!
    var storageRef: FIRStorageReference!
    var userRef: FIRDatabaseReference!
    var myProfs = [String]()
    var myProfFileNames = [String]()
    var userID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ref = FIRDatabase.database().reference(withPath: "users")
        self.storageRef = FIRStorage.storage().reference()
        
        var userDefaults = UserDefaults(suiteName: "group.9-key-proj")
        self.userID = userDefaults?.object(forKey: "uid") as! String
        self.ref.child(self.userID).child("profiles").observe(.value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let profNames = value?.allKeys as! [String]
            
            for prof in profNames{
                
                self.myProfFileNames.append(value?[prof] as! String)
                self.myProfs.append(prof)
            }
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.reloadData()
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.myProfs.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyProfItem", for: indexPath)
        
        cell.textLabel?.text = self.myProfs[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectProf = self.myProfs[indexPath.row]
        let selectProfFileName = self.myProfFileNames[indexPath.row]
        
        let storePath = storageRef.child(self.userID).child(selectProfFileName)
        let localURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.9-key-proj")
        let localDictURL = localURL?.appendingPathComponent(selectProfFileName)
        let downloadTask = storePath.write(toFile: localDictURL!) { url, error in
            if let error = error {
                print("error")
            } else {
                print("success")
            }
        }
        
        var userDefaults = UserDefaults(suiteName: "group.9-key-proj")
        userDefaults!.set(selectProfFileName, forKey: "cur_file_name")
        userDefaults!.synchronize()
        let alert = UIAlertController(title: "Congrats!",
                                      message: "Successfully switch to " + selectProf, preferredStyle: .alert)
        let action = UIAlertAction(title: "Awesome", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
        
        
        
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
