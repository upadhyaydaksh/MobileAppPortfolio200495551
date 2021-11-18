//
//  Userdefaults+Savings.swift
//  BodyFixers
//
//  Created by Hemant Sharma on 22/08/17.
//  Copyright © 2019 PHYX. All rights reserved.
//

import UIKit

extension UserDefaults {
    
    func saveDeviceToken(token: String) {
        UserDefaults.standard.setValue(token, forKey: Constants.UserDefaultKeys.DeviceTokenKey)
        UserDefaults.standard.synchronize()
    }
    
    func getDeviceToken() -> String? {
        if let token = UserDefaults.standard.value(forKey: Constants.UserDefaultKeys.DeviceTokenKey) as? String {
            return token
        }
        return nil
    }
    
    func saveUserEmail(email: String) {
        UserDefaults.standard.setValue(email, forKey: Constants.UserDefaultKeys.UserEmailKey)
        UserDefaults.standard.synchronize()
    }
    
    func getUserEmail() -> String? {
        if let email = UserDefaults.standard.value(forKey: Constants.UserDefaultKeys.UserEmailKey) as? String {
            return email
        }
        return nil
    }
    
    func removeSavedUserEmail() {
        UserDefaults.standard.removeObject(forKey: Constants.UserDefaultKeys.UserEmailKey)
        UserDefaults.standard.synchronize()
    }
}
