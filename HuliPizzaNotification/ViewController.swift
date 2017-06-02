//
//  ViewController.swift
//  HuliPizzaNotification
//
//  Created by Steven Lipton on 1/10/17.
//  Copyright © 2017 Steven Lipton. All rights reserved.
//

import UIKit
import UserNotifications


class ViewController: UIViewController {
    
    private var isNotificationAccessGranted  = false
    

    @IBAction func schedulePizza(_ sender: UIButton) {
        guard isNotificationAccessGranted else {
            return
        }
    }
    @IBAction func makePizza(_ sender: UIButton) {
        guard isNotificationAccessGranted else {
            return
        }
    }
    
    @IBAction func nextPizzaStep(_ sender: UIButton) {
        guard isNotificationAccessGranted else {
            return
        }
    }
    
    @IBAction func viewPendingPizzas(_ sender: UIButton) {
        guard isNotificationAccessGranted else {
            return
        }
    }
    
    @IBAction func viewDeliveredPizzas(_ sender: UIButton) {
        guard isNotificationAccessGranted else {
            return
        }
    }
    
    @IBAction func removeNotification(_ sender: UIButton) {
        guard isNotificationAccessGranted else {
            return
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (isGranted, error) in
            self.isNotificationAccessGranted = isGranted
            if !self.isNotificationAccessGranted{
                let alert = UIAlertController(title: "Need Access", message: "Kindly provide notification access", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { (bool, error) in
                    })
                })
                alert.addAction(alertAction)
                self.show(alert, sender: self)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }


}

