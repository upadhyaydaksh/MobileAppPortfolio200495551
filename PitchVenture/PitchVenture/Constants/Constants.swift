//
//  Constants.swift
//  PitchVenture
//
//  Created by Harshit on 25/10/21.
//  Copyright © 2021 PitchVenture. All rights reserved.
//

import Foundation
import UIKit

let appDel = UIApplication.shared.delegate as! AppDelegate

struct Constants {
    
    struct Default {
        static let animationDuration: TimeInterval = 0.3
        static let contentInsets: UIEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        static let font: UIFont = UIFont.systemFont(ofSize: 14)
        static let itemSpacing: CGFloat = 6
        static let rowSpacing: CGFloat = 6
        static let textFieldCellMinWidth: CGFloat = 60
        static let labelTextColor: UIColor = .darkText
        static let textFieldTextColor: UIColor = .darkText
        static let defaultTokenTopBottomPadding: CGFloat = 4
        static let defaultTokenLeftRightPadding: CGFloat = 8
    }
    
    struct Identifier {
        static let labelCell: String = "ResizingTokenFieldLabelCell"
        static let tokenCell: String = "ResizingTokenFieldTokenCell"
        static let textFieldCell: String = "ResizingTokenFieldTextFieldCell"
    }
    
    struct ScreenSize {
        static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
        static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    }
    
    struct color {
        static let kAPP_COLOR = Constants.color.kRoot_App_Blue_Color
        
        static let kRoot_App_Blue_Color = UIColor(red: 42.0/255.0, green: 172.0/255.0, blue: 150.0/255.0, alpha: 1.0)
    }
    
    static let BASE_URL = ConfigurationManager.sharedManager().APIEndPoint()
    
    static let kKeyboardDistanceFromTextField: CGFloat = 20.0
    
}
