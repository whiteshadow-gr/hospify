/**
 * Copyright (C) 2017 HAT Data Exchange Ltd
 *
 * SPDX-License-Identifier: MPL2
 *
 * This file is part of the Hub of All Things project (HAT).
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/
 */

import KeychainSwift

// MARK: Struct

struct KeychainHelper {

    // MARK: - Keychain methods
    
    /**
     Set a value in the keychain
     
     - parameter String: the key
     - parameter String: the value
     
     - returns: Bool
     */
    static func SetKeychainValue(key: String, value: String) -> Bool {
        
        let keychain = KeychainSwift()
        //keychain.synchronizable = true
        if keychain.set(value, forKey: key, withAccess: .accessibleWhenUnlocked) {
            
            // Keychain item is saved successfully
            return true
        } else {
            
            //let st: OSStatus = keychain.lastResultCode
            return false
        }
    }
    
    /**
     Get a value from keychain
     
     - parameter String: the key
     
     - returns: String
     */
    static func GetKeychainValue(key: String) -> String? {
        
        let keychain = KeychainSwift()
        return keychain.get(key)
    }
    
    /**
     Clear a value from keychain
     
     - parameter String: the key
     
     - returns: String
     */
    static func ClearKeychainKey(key: String) -> Bool {
        
        let keychain = KeychainSwift()
        return keychain.delete(key)
    }
}
