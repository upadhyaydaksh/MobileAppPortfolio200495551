//
//  FontManager.swift
//  PitchVenture
//
//  Created by Harshit on 15/11/21.
//  Copyright © 2021 PitchVenture. All rights reserved.
//

import Foundation
import UIKit

public enum MontserratFont: String {
    case regular = "Montserrat-Regular"
    case semiBold = "Montserrat-SemiBold"
    case semiBoldItalic = "Montserrat-SemiBoldItalic"
    case bold = "Montserrat-Bold"
}

class FontManager: NSObject {
    
    class func montserratFont(fontName: MontserratFont, size: CGFloat) -> UIFont {
        return UIFont(name: fontName.rawValue, size: size) ?? UIFont.systemFont(ofSize: size, weight: .regular)
    }
}
