//
//  PVLoginVC.swift
//  PitchVenture
//
//  Created by Harshit on 25/10/21.
//  Copyright © 2021 PitchVenture. All rights reserved.
//

import UIKit

class PVLoginVC: PVBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Class Methods
    
    class func identifier() -> String {
        return String(describing: self)
    }
    
    class func instantiate() -> PVLoginVC {
        return UIStoryboard.main().instantiateViewController(withIdentifier: PVLoginVC.identifier()) as! PVLoginVC
    }
    
    @IBAction func btnAppleLoginAction(_ sender: Any) {
        let objPVPhoneVerifyVC = PVPhoneVerifyVC.instantiate()
        self.push(vc: objPVPhoneVerifyVC)
    }
    
    @IBAction func btnGoogleLoginAction(_ sender: Any) {
        let objPVPhoneVerifyVC = PVPhoneVerifyVC.instantiate()
        self.push(vc: objPVPhoneVerifyVC)
    }
    
}
