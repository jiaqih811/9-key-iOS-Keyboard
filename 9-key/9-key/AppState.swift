//
//  AppState.swift
//  9-key
//
//  Created by AlexaLiu on 2/18/17.
//  Copyright © 2017 hjq. All rights reserved.
//

import Foundation

//class AppState: NSObject {
//    
//    static let sharedInstance = AppState()
//    
//    var signedIn = false
//    var userID: String?
//    var displayName: String?
//    let dictPath = (try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)).path
//    var dictFileName = "system_default.txt"
//    var dictFilePath = ""
//}

//var AppState_signedIn = false
//var AppState_userID: String?
//var AppState_displayName: String?
//var AppState_dictFileName: String?
//var AppState_dictFilePath: String?

struct Globals{
    static var AppState_signedIn = Bool()
    static var AppState_userID = String()
    static var AppState_displayName = String()
    static var AppState_dictFileName = String()
    static var AppState_dictFilePath = String()

    
}
