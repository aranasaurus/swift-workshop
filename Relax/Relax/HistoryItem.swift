//
//  HistoryItem.swift
//  Relax
//
//  Created by Ryan Arana on 2/9/15.
//  Copyright (c) 2015 PDX-iOS. All rights reserved.
//

import Foundation
import Realm

class HistoryItem: RLMObject {
    dynamic var activity: Activity = Activity()
    dynamic var rating: Double = 0.0
    dynamic var comments: String = ""
    dynamic var loggedAt: NSDate = NSDate()
}
