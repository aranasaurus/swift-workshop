//
//  RelaxViewController.swift
//  Relax
//
//  Created by Ryan Arana on 2/7/15.
//  Copyright (c) 2015 PDX-iOS. All rights reserved.
//

import UIKit
import Realm

class RelaxViewController: UIViewController {

    @IBOutlet weak var activityTitleLabel: UILabel!

    var allActivities: RLMResults {
        return Activity.allObjects()
    }
    var currentActivityIndex: Int = 0 {
        didSet {
            if currentActivityIndex >= Int(allActivities.count) || currentActivityIndex < 0 {
                nextActivity()
                return
            }

            if activityTitleLabel != nil {
                activityTitleLabel.text = allActivities[UInt(currentActivityIndex)].title
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        currentActivityIndex = Activity.currentActivityIndex
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        currentActivityIndex = Activity.currentActivityIndex
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func nextActivity() {
        self.currentActivityIndex = Int(arc4random_uniform(UInt32(allActivities.count)))
    }

    @IBAction func beginActivity() {
        Activity.currentActivityIndex = currentActivityIndex

        // TODO: Implement me!
        println( "beginActivity called... but it's not implemented yet!")
    }
}

