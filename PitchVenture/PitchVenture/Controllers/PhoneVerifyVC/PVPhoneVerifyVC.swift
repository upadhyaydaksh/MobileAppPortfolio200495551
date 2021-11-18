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

    }
    
    // MARK: - Class Methods
    
    class func identifier() -> String {
        return String(describing: self)
    }
    
    class func instantiate() -> PVPhoneVerifyVC {
        return UIStoryboard.main().instantiateViewController(withIdentifier: PVPhoneVerifyVC.identifier()) as! PVPhoneVerifyVC
    }
    
    @IBAction func btnUserRoleSegmentControlAction(_ sender: Any) {
    }
    
    @IBAction func btnSubmitAction(_ sender: Any) {
    }
}
