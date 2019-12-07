//
//  PrintHelper.swift
//  DeezerApp
//
//  Created by Praveen on 05/12/19.
//  Copyright © 2019 Praveen. All rights reserved.
//

import Foundation
import os

class Print {
    
    private static let bundleId = Bundle.main.bundleIdentifier!
    private static let appLog = OSLog(subsystem: Print.bundleId, category: "Default")
    
    public static func error(_ message:Any?, error: Error? = nil, log: OSLog = appLog) {
        #if DEBUG
        if let msg = message {
            print("⎾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾⏋")
            print("⎪‼️🛑🚦 :/> \(msg), Error: \(String(describing: error)), log: \(log.description)")
            print("⎣⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎦")
            
        } else {
            print("ERROR: ERROR IN PRINTING : 🛑 🛑 🛑 🛑 🛑 🛑")
        }
        #endif
    }
    
    public static func info(_ info:Any?) {
        #if DEBUG
        if let msg = info {
            print("ℹ️ ℹ️ :/> \(msg)")
        } else {
            print("INFO ERROR : ℹ️ ℹ️ ℹ️ ℹ️ ℹ️ ℹ️")
        }
        #endif
    }
    
    
    public static func success(_ message:Any?) {
        #if DEBUG
        if let msg = message {
            print("🆗 ✅ ✅ :/> \(msg)")
        } else {
            print("SUCCESS:  ERROR IN PRINTING : ✅ ✅ ✅ ✅ ✅ ✅")
        }
        #endif
    }
    
    
    public static func warning(_ message:Any?) {
        #if DEBUG
        if let msg = message {
            print("⚠️ ⚠️ :/> \(msg)")
        } else {
            print("WARNING: ERROR IN PRINTING : ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️")
        }
        #endif
    }
    
    public static func appState(_ message:Any?) {
        #if DEBUG
        if let msg = message {
            print("📱-> \(msg)")
        } else {
            print("APPSTATE: ERROR IN PRINTING : 📱📱📱📱📱📱📱")
        }
        #endif
    }
    
}
