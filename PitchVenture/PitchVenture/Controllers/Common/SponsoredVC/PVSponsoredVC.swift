//
//  PVSponsoredVC.swift
//  PitchVenture
//
//  Created by Harshit on 14/02/22.
//  Copyright © 2022 PitchVenture. All rights reserved.
//

import UIKit

class PVSponsoredVC: PVBaseVC {

    
    @IBOutlet weak var btnUpgrade: UIButton!
    @IBOutlet weak var btnNotNow: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setLeftBarButton()
        self.setNavigationTitle("Upgrade Premium")
    }
    
    class func instantiate() -> PVSponsoredVC {
        return UIStoryboard.main().instantiateViewController(withIdentifier: PVSponsoredVC.identifier()) as! PVSponsoredVC
    }
    
    @IBAction func btnUpgradeAction(_ sender: Any) {
        //API TO UPGRADE
    }
    
    @IBAction func btnNotNowAction(_ sender: Any) {
        self.popController(vc: nil)
    }
    
}
