//
//  PVPhoneVerifyVC.swift
//  PitchVenture
//
//  Created by Harshit on 25/10/21.
//  Copyright © 2021 PitchVenture. All rights reserved.
//

import UIKit

class PVPhoneVerifyVC: PVBaseVC {

    //MARK: - Outlets
    @IBOutlet weak var vwPhoneNumber: PVView!
    @IBOutlet weak var txtPhoneNumber: PVTextFieldView!
    @IBOutlet weak var btnUserRoleSegmentControl: UISegmentedControl!
    
    var account : Account = Account()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtPhoneNumber.viewMode = .phoneNumber
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.setNavigationTitle("Verify Phone")
        
    }
    
    // MARK: - Class Methods
    
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
        if self.btnUserRoleSegmentControl.selectedSegmentIndex == 0 {
            //STORE OWNER
            self.account.isFranchise = false
        } else {
            //FRANCHISOR
            self.account.isFranchise = true
        }
    }
    
    
    @IBAction func btnSubmitAction(_ sender: Any) {
        if self.btnUserRoleSegmentControl.selectedSegmentIndex == 0 {
            // Store Owner
            //CREATE USER AND SELECT ROLE
            
            let obj = PVInputLocationVC.instantiate()
            self.account.storeOwner?.phoneNumber = self.txtPhoneNumber.phone
            self.account.storeOwner?.countryCode = self.txtPhoneNumber.countryCode
            obj.account = self.account
            self.push(vc: obj)
        } else {
            // Franchisor
            
            let obj = PVFranchisorsSignupVC.instantiate()
            self.account.franchise?.phoneNumber = self.txtPhoneNumber.phone
            self.account.franchise?.countryCode = self.txtPhoneNumber.countryCode
            obj.account = self.account
            self.push(vc: obj)
        }
    }
}
