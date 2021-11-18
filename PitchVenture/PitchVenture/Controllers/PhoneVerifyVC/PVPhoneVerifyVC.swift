//
//  PVPhoneVerifyVC.swift
//  PitchVenture
//
//  Created by Harshit on 25/10/21.
//  Copyright © 2021 PitchVenture. All rights reserved.
//

import UIKit

class PVPhoneVerifyVC: PVBaseVC {

    @IBOutlet weak var vwPhoneNumber: PVView!
    @IBOutlet weak var txtPhoneNumber: PVTextFieldView!
    @IBOutlet weak var btnUserRoleSegmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtPhoneNumber.viewMode = .phoneNumber
    }
    
    // MARK: - Class Methods
    
    class func identifier() -> String {
        return String(describing: self)
    }
    
    class func instantiate() -> PVPhoneVerifyVC {
        return UIStoryboard.main().instantiateViewController(withIdentifier: PVPhoneVerifyVC.identifier()) as! PVPhoneVerifyVC
    }
    
    func isMobileNumberValid() -> Bool {
        guard let _ = txtPhoneNumber.countryCode else { return false }
        guard let _ = txtPhoneNumber.phone else {
            PVMessage.showWarningWithMessage(message: "Please enter your phone number.")
            return false
        }
        return true
    }
    
    @IBAction func btnUserRoleSegmentControlAction(_ sender: Any) {
    }
    
    @IBAction func btnSubmitAction(_ sender: Any) {
        // PHONE NUMBER VERIFY
        if isMobileNumberValid() {
            guard let countryCode = txtPhoneNumber.countryCode else { return }
            guard let phoneNumber = txtPhoneNumber.phone else { return }
            let param = ["countryCode": countryCode, "phone": phoneNumber]
            //self.signIn(parameters: param as [String : AnyObject])
            print(param)
        }
    }
}
