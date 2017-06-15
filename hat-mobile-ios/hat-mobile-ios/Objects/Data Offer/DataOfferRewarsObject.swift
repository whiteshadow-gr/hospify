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

import SwiftyJSON

// MARK: Struct

struct DataOfferRewarsObject {
    
    // MARK: - Variables
    
    var rewardType: String = ""
    var vendor: String = ""
    var vendorURL: String = ""
    var value: String = ""
    
    // MARK: - Initialiser
    
    /**
     The default initialiser. Initialises everything to default values.
     */
    init() {
        
        rewardType = ""
        vendor = ""
        vendorURL = ""
        value = ""
    }
    
    /**
     It initialises everything from the received JSON file from the HAT
     */
    init(dictionary: Dictionary<String, JSON>) {
        
        if let tempRewardType = dictionary["rewardType"]?.string {
            
            rewardType = tempRewardType
        }
        
        if let tempVendor = dictionary["vendor"]?.string {
            
            vendor = tempVendor
        }
        
        if let tempVendorUrl = dictionary["vendorUrl"]?.string {
            
            vendorURL = tempVendorUrl
        }
        
        if let tempValue = dictionary["value"]?.string {
            
            value = tempValue
        }
    }
}
