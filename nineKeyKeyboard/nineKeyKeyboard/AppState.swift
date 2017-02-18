//
//  AppState.swift
//  nineKeyKeyboard
//
//  Created by AlexaLiu on 2/17/17.
//  Copyright © 2017 hjq. All rights reserved.
//

import Foundation


class AppState: NSObject {
    
    static let sharedInstance = AppState()
    
    var signedIn = false
    var userID: String?
    var displayName: String?
    var dictFileName = "system_default.txt"
}
