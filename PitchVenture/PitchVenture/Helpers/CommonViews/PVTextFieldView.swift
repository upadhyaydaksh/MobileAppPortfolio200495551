//
//  PVTextFieldView.swift
//  PitchVenture
//
//  Created by Harshit on 18/11/21.
//  Copyright © 2021 PitchVenture. All rights reserved.
//

import Foundation
import UIKit
import FlagPhoneNumber

enum PVUserTextFieldViewMode {
    case phoneNumber
    case other
}

class PVTextFieldView: UIView {
    
    @IBOutlet weak var textField: PVTextField!
    
    
    @IBOutlet weak var textFieldPhonePicker: FPNTextField!
    
    var countryCode: String? {
        if let country = textFieldPhonePicker.selectedCountry {
            return country.phoneCode
        }
        return nil
    }
    
    var phone: String? {
        return textFieldPhonePicker.getRawPhoneNumber()
    }
    
    var text: String? {
        set {
            textField.text = newValue
        }
        get {
            return textField.text?.trimmedString()
        }
    }
    
    var placeholder: String? {
        set {
            textField.placeholder = newValue
        }
        get {
            return textField.placeholder
        }
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - Private Helper Methods
    
    // Performs the initial setup.
    fileprivate func setupView() {
        let view = viewFromNibForClass()
        view.frame = bounds
        view.autoresizingMask = [
            UIView.AutoresizingMask.flexibleWidth,
            UIView.AutoresizingMask.flexibleHeight
        ]
        addSubview(view)
        
        initialize()
    }
    
    // Loads a XIB file into a view and returns this view.
    fileprivate func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    private func initialize() {
        
        // Custom the size/edgeInsets of the flag button
        textFieldPhonePicker.flagButtonSize = CGSize(width: 40, height: 40)
        //textFieldPhonePicker.flagButtonEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 5)
        
        textFieldPhonePicker.font = FontManager.montserratFont(fontName: .semiBold, size: 17)
        
        textFieldPhonePicker.backgroundColor = UIColor.clear
        
        // Set the country CA, US, Japan, Korea, India
        textFieldPhonePicker.setCountries(including: [.CA, .US, .IN])
        
        
        textFieldPhonePicker.setFlag(countryCode: FPNCountryCode.CA)
        
        //textFieldPhonePicker.textColor = Constants.color.kAPP_COLOR
        
        textFieldPhonePicker.textColor = .black
        textFieldPhonePicker.tintColor = textFieldPhonePicker.textColor!
        textFieldPhonePicker.attributedPlaceholder = NSAttributedString(string: textFieldPhonePicker.placeholder ?? "", attributes:[NSAttributedString.Key.foregroundColor: Constants.color.kTEXTFIELD_PLACEHOLDER_COLOR])
        textFieldPhonePicker.font = FontManager.montserratFont(fontName: .semiBold, size: 16)
        
        updateTextFieldVisibility()
    }
    
    
    // MARK: - Class Functions
    
    class func identifier() -> String {
        return String(describing: self)
    }
    
    var viewMode: PVUserTextFieldViewMode = .other {
        didSet {
            updateTextFieldVisibility()
        }
    }
    
    @IBInspectable open var leftViewImage: UIImage? {
        didSet {
            self.textField.leftViewImage = leftViewImage
        }
    }

    @IBInspectable open var hintString: String? {
        set {
            //lblHint.text = newValue
            textField.placeholder = newValue
        }
        get {
            return nil
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    func updateTextFieldVisibility() {
        if viewMode == .phoneNumber {
            textField.isHidden = true
            textFieldPhonePicker.isHidden = false
        } else {
            textField.isHidden = false
            textFieldPhonePicker.isHidden = true
        }
        textFieldPhonePicker.layoutSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
            var radius: CGFloat = 0.0
            if cornerRadius != 0 {
                radius = cornerRadius
            }
            self.layer.cornerRadius = radius
    }
}
