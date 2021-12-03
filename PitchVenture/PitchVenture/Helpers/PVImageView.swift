//
//  PVImageView.swift
//  PitchVenture
//
//  Created by Harshit on 02/12/21.
//  Copyright © 2021 PitchVenture. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class PVImageView: UIImageView {
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }

    @IBInspectable var leftRight: Bool = false {
        didSet {
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    @IBInspectable var cicular: Bool = false {
        didSet {
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var radius: CGFloat = 0.0
        if cornerRadius != 0 {
            radius = cornerRadius
        } else if cicular {
            radius = self.bounds.size.width / 2.0
        } else if leftRight {
            radius = self.bounds.size.height / 2.0
        }
        self.layer.cornerRadius = radius
    }

}
