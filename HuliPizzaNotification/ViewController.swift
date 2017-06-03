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
    
    private let SCHEDULED_PIZZA_IDENTIFIER = "scheduled.pizza.notification"
    private let MAKE_PIZZA_IDENTIFIER = "make.pizza.identifier"
    
    private var isNotificationAccessGranted  = false
    
    private func makePizzaContent() -> UNMutableNotificationContent{
        let content = UNMutableNotificationContent()
        content.title = "Make Pizza"
        content.body = "Let's make some pizza"
        content.userInfo = ["step":0]
        return content
    }

    private func createNotification(identifier : String, content : UNNotificationContent, trigger: UNNotificationTrigger?){
        let notificationRequest = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(notificationRequest) { (error) in
            if nil != error{
                
            }
        }
    }
    
    @IBAction func schedulePizza(_ sender: UIButton) {
        guard isNotificationAccessGranted else {
            return
        }
        let content = UNMutableNotificationContent()
        content.title = "Scehduled Pizza"
        content.body = "Time to  make some pizza"
        let dateComponents : Set<Calendar.Component> = [.minute,.hour,.second]
        var dateToMatch = Calendar.current.dateComponents(dateComponents, from: Date())
        dateToMatch.second = dateToMatch.second! + 5
        let trigger  = UNCalendarNotificationTrigger(dateMatching: dateToMatch, repeats: false)
        createNotification(identifier: SCHEDULED_PIZZA_IDENTIFIER, content: content, trigger: trigger)
    }
    @IBAction func makePizza(_ sender: UIButton) {
        guard isNotificationAccessGranted else {
            return
        }
        let content = makePizzaContent()
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10.0, repeats: false)
        createNotification(identifier: MAKE_PIZZA_IDENTIFIER, content: content, trigger: trigger)
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
        UNUserNotificationCenter.current().delegate = self
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

extension ViewController: UNUserNotificationCenterDelegate{
    //MARK: - UNUserNotificationCenterDelegate methods
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.badge,.sound])
    }
}

