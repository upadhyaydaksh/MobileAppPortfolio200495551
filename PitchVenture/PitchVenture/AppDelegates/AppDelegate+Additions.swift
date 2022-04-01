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
import FirebaseMessaging

extension AppDelegate {
    
    func setHomeVC() {
        let nav: PVNavigationController = UIStoryboard.main().instantiateViewController(withIdentifier: "PVNavigationController") as! PVNavigationController
        let obj = PVStoreOwnerHomeVC.instantiate()
        nav.setViewControllers([obj], animated: false)
        nav.isNavigationBarHidden = false
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
    }
    
    func setRootViewController() {
        if PVUserManager.sharedManager().isUserLoggedIn() {
            // Move to HomeVC
            print(PVUserManager.sharedManager().loadActiveUser())
            self.setHomeVC()
        } else {
            
//            self.setHomeVC()
            PVUserManager.sharedManager().deleteActiveUser()
            //Set login page as root
            let nav: PVNavigationController = UIStoryboard.main().instantiateViewController(withIdentifier: "PVNavigationController") as! PVNavigationController
            let obj = PVLoginVC.instantiate()
            nav.setViewControllers([obj], animated: false)
            nav.isNavigationBarHidden = true
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

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(fcmToken! )")

        UserDefaults.standard.set("\(fcmToken!)", forKey: "fcmToken")
      // TODO: If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
}

@available(iOS 10, *)
extension AppDelegate: UNUserNotificationCenterDelegate {
  // Receive displayed notifications for iOS 10 devices.
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
                              withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions)
                                -> Void) {
    let userInfo = notification.request.content.userInfo

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)

    // ...

    // Print full message.
    print(userInfo)

    // Change this to your preferred presentation option
    completionHandler([[.alert, .sound]])
  }

  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
    let userInfo = response.notification.request.content.userInfo

    // ...

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)

    // Print full message.
    print(userInfo)

    completionHandler()
  }
}
