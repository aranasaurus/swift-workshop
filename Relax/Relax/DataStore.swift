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

    class func toArray<T: RLMObject>(s: RLMResults) -> [T] {
        var results = [T]()

        for i in 0 ..< s.count {
            let a = s.objectAtIndex(i) as T
            results.append(a)
        }

        return results
    }

    // MARK: Activities

    class func activitiesPath() -> String {
        return NSBundle.mainBundle().pathForResource("DefaultActivities", ofType: "plist")!
    }

    class var realm: RLMRealm {
        return RLMRealm.defaultRealm()
    }

    class func loadActivities() -> [Activity] {
        return toArray(Activity.allObjects())
    }

    class func loadDefaultActivities() -> Bool {
        println( "Loading default activities from \(activitiesPath()).")
        if let arr = NSArray(contentsOfFile: activitiesPath()) as? [AnyObject] {
            let defs = arr.map({ (t:AnyObject?) -> Activity in
                if let title = t as? String {
                    return Activity(title: title)
                }
                return Activity(title: "")
            })
            
            realm.beginWriteTransaction()
            realm.addObjects(defs)
            realm.commitWriteTransaction()
            return true
        }
        
        return false
    }
    
    class func addActivity(activity: Activity) {
        realm.beginWriteTransaction()
        realm.addObject(activity)
        realm.commitWriteTransaction()
    }
    
    class func removeActivity(activity: Activity) {
        realm.beginWriteTransaction()
        realm.deleteObject(activity)
        realm.commitWriteTransaction()
    }

    // This is not ideal, but without it we'd have to put the realm begin/commit transaction calls in the VCs, which is
    // also not ideal.
    class func updateActivity(activity: Activity, withTitle title: String) {
        realm.beginWriteTransaction()
        activity.title = title
        realm.commitWriteTransaction()
    }
    
    class var currentActivityIndex: Int {
        get {
            return NSUserDefaults.standardUserDefaults().integerForKey("currentActivityIndex") ?? -1
        }
        set {
            NSUserDefaults.standardUserDefaults().setInteger(newValue, forKey: "currentActivityIndex")
        }
    }
    
    
    // MARK: History Items
    
    class func loadHistoryItems() -> [HistoryItem] {
        return toArray(HistoryItem.allObjects())
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