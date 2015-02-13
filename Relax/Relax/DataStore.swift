//
//  DataStore.swift
//  Relax
//
//  Created by Ryan Arana on 2/9/15.
//  Copyright (c) 2015 PDX-iOS. All rights reserved.
//

import Foundation
import Realm

class DataStore {

    // MARK: Activities

    class func activitiesPath() -> String {
        return NSBundle.mainBundle().pathForResource("DefaultActivities", ofType: "plist")!
    }

    class func loadActivities() -> [Activity] {
        var activities = Activity.allObjects()
        if activities.count == 0 {
            let realm = RLMRealm.defaultRealm()
            let defaultActivities = loadDefaultActivities()
            realm.beginWriteTransaction()
            realm.addObjects(defaultActivities)
            realm.commitWriteTransaction()
        }

        activities = Activity.allObjects()
        var results = [Activity]()
        for i in 0 ..< activities.count {
            let a = activities.objectAtIndex(i) as Activity
            results.append(a)
        }

        return results
    }

    class func loadDefaultActivities() -> [Activity] {
        println( "Loading default activities from \(activitiesPath()).")
        if let arr = NSArray(contentsOfFile: activitiesPath()) as? [AnyObject] {
            return arr.map({ (t:AnyObject?) -> Activity in
                if let title = t as? String {
                    return Activity(title: title)
                }
                return Activity(title: "")
            })
        }
        return [Activity]()
    }

    class func addActivity(activity: Activity) {
        // TODO: Implement me!
        println("addActivity called... but it's not implemented yet!")
    }

    class func removeActivity(activity: Activity) {
        // TODO: Implement me!
        println("removeActivity called... but it's not implemented yet!")
    }

    class func currentActivity() -> Activity {
        // TODO: Implement me!
        assert(false, "Unimplemented")
    }

    class func setCurrentActivity(activity: Activity) {
        // TODO: Implement me!
        println("setCurrentActivity called... but it's not implemented yet!")
    }


    // MARK: History Items

    class func historyItemsPath() -> String {
        return NSBundle.mainBundle().pathForResource("HistoryItems", ofType: "plist")!
    }

    class func loadHistoryItems() -> [HistoryItem] {
        // TODO: Implement me!
        println("loadHistoryItems called... but it's not implemented yet!")

        return [HistoryItem]()
    }

    class func addHistoryItem(item: HistoryItem) {
        // TODO: Implement me!
        println("addHistoryItem called... but it's not implemented yet!")
    }

    class func removeHistoryItem(item: HistoryItem) {
        // TODO: Implement me!
        println("removeHistoryItem called... but it's not implemented yet!")
    }
}