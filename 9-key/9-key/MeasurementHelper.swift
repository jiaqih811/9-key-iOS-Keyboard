//
//  MeasurementHelper.swift
//  9-key
//
//  Created by AlexaLiu on 2/18/17.
//  Copyright © 2017 hjq. All rights reserved.
//

import Foundation

import Firebase

class MeasurementHelper: NSObject {
    
    static func sendLoginEvent() {
        FIRAnalytics.logEvent(withName: kFIREventLogin, parameters: nil)
    }
    
    static func sendLogoutEvent() {
        FIRAnalytics.logEvent(withName: "logout", parameters: nil)
    }
    
    static func sendMessageEvent() {
        FIRAnalytics.logEvent(withName: "message", parameters: nil)
    }
}
