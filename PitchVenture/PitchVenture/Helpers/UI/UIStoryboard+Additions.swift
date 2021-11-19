//
//  UIStoryboard+Additions.swift
//  BodyFixers
//
//  Created by Hemant Sharma on 19/06/17.
//  Copyright © 2019 PHYX. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    
    class func main() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    class func chat() -> UIStoryboard {
        return UIStoryboard(name: "Chat", bundle: nil)
    }
    
    class func call() -> UIStoryboard {
        return UIStoryboard(name: "Call", bundle: nil)
    }
    
    class func user() -> UIStoryboard {
        return UIStoryboard(name: "User", bundle: nil)
    }
}
