//
//  SetupViewController.swift
//  Relax
//
//  Created by Ryan Arana on 2/7/15.
//  Copyright (c) 2015 PDX-iOS. All rights reserved.
//

import UIKit

class SetupViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    var activities: [Activity] {
        return DataStore.loadActivities()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func addActivity(sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Add Activity", message: nil, preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (_) in }
        let addAction = UIAlertAction(title: "Add", style: .Default) { (_) in
            let textField = alertController.textFields![0] as UITextField
            DataStore.addActivity(Activity(title: textField.text))
            self.tableView.beginUpdates()
            self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
            self.tableView.endUpdates()
        }

        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Title"

            NSNotificationCenter.defaultCenter().addObserverForName(UITextFieldTextDidChangeNotification, object: textField, queue: NSOperationQueue.mainQueue()) { (notification) in
                addAction.enabled = textField.text != ""
            }
        }

        alertController.addAction(cancelAction)
        alertController.addAction(addAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    // MARK: UITableViewDataSource

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("setupCell") as UITableViewCell

        if indexPath.row < activities.count {
            let activity = activities[indexPath.row]
            cell.textLabel?.text = activity.title
        }

        return cell
    }

    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return indexPath.row < activities.count
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            if indexPath.row < activities.count {
                let activity = activities[indexPath.row]
                DataStore.removeActivity(activity)
                tableView.beginUpdates()
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                tableView.endUpdates()
            }
        }
    }

    // MARK: UITableViewDelegate

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let alertController = UIAlertController(title: "Edit Activity", message: nil, preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (_) in }
        let saveAction = UIAlertAction(title: "Save", style: .Default) { (_) in
            let textField = alertController.textFields![0] as UITextField

            DataStore.updateActivity(self.activities[indexPath.row], withTitle: textField.text)

            self.tableView.beginUpdates()
            self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
            self.tableView.endUpdates()
        }

        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Title"
            textField.text = self.activities[indexPath.row].title

            NSNotificationCenter.defaultCenter().addObserverForName(UITextFieldTextDidChangeNotification, object: textField, queue: NSOperationQueue.mainQueue()) { (notification) in
                saveAction.enabled = textField.text != ""
            }
        }

        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }

}
