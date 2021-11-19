//
//  UITextField+Additions.swift
//  BodyFixers
//
//  Created by Hemant Sharma on 27/10/17.
//  Copyright © 2019 PHYX. All rights reserved.
//

import UIKit

extension UITextField {
    
    func setRightPaddingView(strImgname: String?) {
        if strImgname != nil {
            let vw = UIView(frame: CGRect(x: 0, y: 0, width: 40.0 , height: 40.0))
            vw.backgroundColor = UIColor.clear
            let imageView = UIImageView(image: UIImage(named: strImgname!))
            imageView.frame = CGRect(x: 0, y: 0, width: 17.0 , height: 17.0)
            vw.addSubview(imageView)
            imageView.center = CGPoint(x: vw.frame.size.width/2, y: vw.frame.size.width/2)
            imageView.contentMode = .scaleAspectFit
            self.rightViewMode = .always
            self.rightView = vw
        } else {
            self.rightView = nil
        }
        
    }
    
    func setLeftPaddingView(width: CGFloat) {
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: width, height: self.frame.size.height))
        self.leftViewMode = .always
        self.leftView = view
    }
    
    func setLeftPaddingViewWithText(text: String) {
        let label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 50.0, height: self.frame.size.height))
        label.backgroundColor = UIColor.black
        label.textColor = UIColor.white
        label.font = self.font
        label.textAlignment = .center
        label.text = text
        self.leftViewMode = .always
        self.leftView = label
    }
    
    func removeLeftPaddingView() {
        self.leftView = nil
    }
    
    func appSpecificTextField() {
        self.tintColor = self.textColor!
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes:[NSAttributedString.Key.foregroundColor: Constants.color.kTEXTFIELD_PLACEHOLDER_COLOR])
        self.layer.borderColor = Constants.color.kTextFieldBorderColor.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 5.0
    }
    
    func appSpecificErrorTextField() {
        self.tintColor = self.textColor!
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes:[NSAttributedString.Key.foregroundColor: Constants.color.kTEXTFIELD_PLACEHOLDER_COLOR])
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 5.0
    }
    
}
