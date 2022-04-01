//
//  FRUserManager.swift
//  BodyFixers
//
//  Created by Hemant Sharma on 29/06/17.
//  Copyright © 2019 PHYX. All rights reserved.
//

import UIKit
import ObjectMapper
import CoreLocation
import SVProgressHUD

enum RequestResponseStatusCode: Int {
    case error = 0
    case success = 1
    case circleFull = 2
    case alreadyAdded = 3
}

class PVUserManager: NSObject {
    
    fileprivate var _activeUser: Account?
    
    var activeUser: Account! {
        get {
            return _activeUser
        }
        set {
            _activeUser = newValue
            
            if let _ = _activeUser {
                self.saveActiveUser()
            }
        }
    }
    
    // MARK: - KeyChain / User Defaults / Flat file / XML
    
    /**
     Load last logged user data, if any
     */
    func loadActiveUser() {
        
        guard let decodedUser = UserDefaults.standard.object(forKey: Constants.UserDefaultKeys.ACTIVE_USER_KEY) as? Data,
            let user = NSKeyedUnarchiver.unarchiveObject(with: decodedUser) as? Account
            else {
                return
        }
        self.activeUser = user
    }
    
    /**
     Save current user data
     */
    func saveActiveUser() {
        UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: self.activeUser!) as AnyObject?, forKey: Constants.UserDefaultKeys.ACTIVE_USER_KEY)
        UserDefaults.standard.synchronize()
    }
    
    
    /**
     Delete current user data
     */
    func deleteActiveUser() {
        // remove active user from storage
        UserDefaults.standard.removeObject(forKey: Constants.UserDefaultKeys.ACTIVE_USER_KEY)
        UserDefaults.standard.synchronize()
        // free user object memory
        self.activeUser = nil
        
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    // MARK: Singleton Instance
    fileprivate static let _sharedManager = PVUserManager()
    
    class func sharedManager() -> PVUserManager {
        return _sharedManager
    }
    
    
    fileprivate override init() {
        // initiate any queues / arrays / filepaths etc
        super.init()
        
        // Load last logged user data if exists
        if isUserLoggedIn() {
            loadActiveUser()
        }
    }
    
    func printUserObject() {
        if self.activeUser != nil {
            debugPrint("Access token: \(String(describing: self.activeUser.id))")
            debugPrint("id: \(String(describing: self.activeUser.id))")
        }
    }
    
    func isUserLoggedIn() -> Bool {
        guard let _ = UserDefaults.standard.object(forKey: Constants.UserDefaultKeys.ACTIVE_USER_KEY)
            else {
                return false
        }
        return true
    }
    
    func isProfileComplete() -> Bool {
        guard let _ = UserDefaults.standard.object(forKey: Constants.UserDefaultKeys.ACTIVE_USER_KEY)
            else {
                return false
        }
        if self.activeUser.isComplete == false {
            return false
        }
        return true
    }
    
    func logout() {
        self.setSplashAsRoot()
    }
    
    func setSplashAsRoot() {
        self.deleteActiveUser()
    }
    
}
