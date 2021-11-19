//
//  PVHomeVC.swift
//  PitchVenture
//
//  Created by Harshit on 18/11/21.
//  Copyright © 2021 PitchVenture. All rights reserved.
//

import UIKit

class PVHomeVC: PVBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    class func identifier() -> String {
        return String(describing: self)
    }
    
    class func instantiate() -> PVHomeVC {
        return UIStoryboard.main().instantiateViewController(withIdentifier: PVHomeVC.identifier()) as! PVHomeVC
    }
}
