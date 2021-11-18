//
//  String+Attributions.swift
//  Zirco
//
//  Created by Hemant Sharma on 14/02/18.
//  Copyright © 2019 PHYX. All rights reserved.
//

import UIKit

extension String {
    
    func attributedString(attributes: [NSAttributedString.Key: Any], substring: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        var rangeOfSubstring: NSRange?
        if self.contains(substring) {
            rangeOfSubstring = (self as NSString).range(of: substring)
        }
        if rangeOfSubstring != nil {
            attributedString.addAttributes(attributes, range: rangeOfSubstring!)
        }
        
        return attributedString
    }
    
    func fullUnderlineString() -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        let rangeOfSubstring: NSRange? = (self as NSString).range(of: self)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: rangeOfSubstring!)
        return attributedString
    }
}