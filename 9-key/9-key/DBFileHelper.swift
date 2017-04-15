//
//  DBFileHelper.swift
//  9-key
//
//  Created by AlexaLiu on 3/30/17.
//  Copyright © 2017 hjq. All rights reserved.
//

import Foundation
import Firebase

let ref = FIRDatabase.database().reference()
let storageRef = FIRStorage.storage().reference()
let localURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: GROUP_NAME)


func downloadDict(_ userID: String?, _ dict: String?, _ isForce: Bool?) {
    var dbPath: FIRStorageReference!
    if userID == nil {
        dbPath = storageRef.child("System").child(dict! + ".txt")
    } else {
        dbPath = storageRef.child(userID!).child(dict! + ".txt")
    }
    
    let localDictURL = localURL?.appendingPathComponent(dict!).appendingPathExtension("txt")
    if isForce == false && FileManager.default.fileExists(atPath: (localDictURL?.path)!) {
        print(dict! + " dict already exists")
    } else {
        let downloadTask = dbPath.write(toFile: localDictURL!) { url, error in
            if let error = error {
                print(dict! + " error download")
            } else {
                print(dict! + " success download")
            }
        }
    }
}
func uploadUserDict(_ userID: String?, _ dict: String?) {
    let dbUsertPath = storageRef.child(userID!).child(dict! + ".txt")
    let localDictURL = localURL?.appendingPathComponent(dict!).appendingPathExtension("txt")
    while !FileManager.default.fileExists(atPath: (localDictURL?.path)!) {
        print(dict! + " not exist")
    }
    let uploadTask = dbUsertPath.putFile(localDictURL!, metadata: nil) { metadata, error in
        if let error = error {
            print(dict! + "error upload")
        } else {
            print(dict! + "success upload")
            // Metadata contains file metadata such as size, content-type, and download URL.
            let downloadURL = metadata!.downloadURL()
        }
    }
}
