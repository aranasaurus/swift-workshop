//
//  Activity.swift
//  Relax
//
//  Created by Ryan Arana on 2/7/15.
//  Copyright (c) 2015 PDX-iOS. All rights reserved.
//

import Foundation
import Realm

class Activity: RLMObject {
    dynamic var title = ""
    var historyItems: [HistoryItem] {
        return linkingObjectsOfClass("HistoryItem", forProperty: "activity") as [HistoryItem]
    }

    convenience init(title: String) {
        self.init()
        self.title = title
    }
    
    class var currentActivityIndex: Int {
        get {
            return NSUserDefaults.standardUserDefaults().integerForKey("currentActivityIndex") ?? -1
        }
        set {
            NSUserDefaults.standardUserDefaults().setInteger(newValue, forKey: "currentActivityIndex")
        }
    }
}

