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
        
    }
    
    func setupKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.keyboardDistanceFromTextField = Constants.kKeyboardDistanceFromTextField
    }
}
