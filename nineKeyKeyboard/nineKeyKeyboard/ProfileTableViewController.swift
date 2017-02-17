//
//  ProfileTableViewController.swift
//  nineKeyKeyboard
//
//  Created by AlexaLiu on 2/17/17.
//  Copyright © 2017 hjq. All rights reserved.
//

import UIKit
import Firebase

class ProfileTableViewController: UITableViewController {
    
    var ref: FIRDatabaseReference!
    var userRef: FIRDatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ref = FIRDatabase.database().reference(withPath: "users")
//        self.userRef = FIRDatabase.database().reference(withPath: "commonProfiles")
        
        let userID = AppState.sharedInstance.userID
//        self.ref.child("users").child(userID!).child("profile").observe(.value, with: { (snapshot) in
//            myTrips = []
//            myRequests = []
            
//            let key  = snapshot.key as String
//            let value = snapshot.value as? NSDictionary
//            let tripKeys = value?.allKeys as! [String]
//            let temp = tripKeys[0]
//            debugPrint("hello")
//            debugPrint(key)
        
//            
//            for currTrip in tripKeys{
//                trip.from = (value![currTrip]! as! NSDictionary)["from"]! as! String
//                trip.to = (value![currTrip]! as! NSDictionary)["to"]! as! String
//                trip.date = (value![currTrip]! as! NSDictionary)["date"]! as! String
//                trip.seats = (value![currTrip]! as! NSDictionary)["seats"]! as! String
//                trip.notes = (value![currTrip]! as! NSDictionary)["notes"]! as! String
//                trip.tripID = currTrip
//                trip.ownerID = (value![currTrip]! as! NSDictionary)["ownerID"]! as! String
//                trip.price = (value![currTrip]! as! NSDictionary)["price"]! as! String
//                trip.pickUp = (value![currTrip]! as! NSDictionary)["pickUp"]! as! String
//                trip.riderID = (value![currTrip]! as! NSDictionary)["riderID"]! as! String
//                self.tripRequests = (value![currTrip]! as! NSDictionary)["requestList"]! as! String
//                
//                let requestArr = self.tripRequests.components(separatedBy: ",")
//                print(requestArr)
//                
//                
//                debugPrint(trip.ownerID)
//                // TODO: DO linear search?
//                
//                if (trip.ownerID == userID) {
//                    if (myTrips.isEmpty || myTrips[myTrips.endIndex - 1].tripID != trip.tripID) {
//                        myTrips.append(trip)
//                    }
//                }
//                
//                if (requestArr.contains(userID!)) {
//                    if (myRequests.isEmpty || myRequests[myRequests.endIndex - 1].tripID != trip.tripID) {
//                        myRequests.append(trip)
//                    }
//                }
//                
//                
//            }
//            
//            
//            self.tableView.delegate = self
//            self.tableView.dataSource = self
//            self.tableView.reloadData()
//            
//            
//            
//        }) { (error) in
//            print(error.localizedDescription)
//        }


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
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
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
