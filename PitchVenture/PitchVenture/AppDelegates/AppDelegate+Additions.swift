//
//  AppDelegate+Additions.swift
//  PitchVenture
//
//  Created by Harshit on 25/10/21.
//  Copyright © 2021 PitchVenture. All rights reserved.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift

extension AppDelegate {
    
    func setRootViewController() {
        if PVUserManager.sharedManager().isProfileComplete() {
            // Move to HomeVC
            let nav: PVNavigationController = UIStoryboard.main().instantiateViewController(withIdentifier: "PVNavigationController") as! PVNavigationController
            let obj = PVHomeVC.instantiate()
            nav.setViewControllers([obj], animated: false)
            self.window?.rootViewController = nav
            
        } else {
            PVUserManager.sharedManager().deleteActiveUser()
            //Set login page as root
            let nav: PVNavigationController = UIStoryboard.main().instantiateViewController(withIdentifier: "PVNavigationController") as! PVNavigationController
            let obj = PVLoginVC.instantiate()
            nav.setViewControllers([obj], animated: false)
            self.window?.rootViewController = nav
        }
    }
    
    func setupKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.keyboardDistanceFromTextField = Constants.kKeyboardDistanceFromTextField
    }
    
//    func configureNotification() {
//        
//        if #available(iOS 10.0, *) {
//            // For iOS 10 display notification (sent via APNS)
//            UNUserNotificationCenter.current().delegate = self
//            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
//            UNUserNotificationCenter.current().requestAuthorization(
//                options: authOptions,
//                completionHandler: {_, _ in })
//            // For iOS 10 data message (sent via FCM
//            Messaging.messaging().delegate = self
//        } else {
//            let settings: UIUserNotificationSettings =
//                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
//            UIApplication.shared.registerUserNotificationSettings(settings)
//        }
//        
//        UIApplication.shared.registerForRemoteNotifications()
//        
//    }
}
