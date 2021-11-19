//
//  PVInputLocationVC.swift
//  PitchVenture
//
//  Created by Daksh Upadhyay on 2021-11-19.
//  Copyright © 2021 PitchVenture. All rights reserved.
//

import UIKit

class PVInputLocationVC: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var btnImagePicker: UIButton!
    @IBOutlet weak var txtApartmentNo: UITextField!
    @IBOutlet weak var txtAddressLine1: UITextField!
    @IBOutlet weak var txtAddressLine2: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtProvince: UITextField!
    @IBOutlet weak var txtPostalCode: UITextField!
    @IBOutlet weak var btnSubmit: PVButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Class Methods
    
    class func identifier() -> String {
        return String(describing: self)
    }
    
    class func instantiate() -> PVInputLocationVC {
        return UIStoryboard.main().instantiateViewController(withIdentifier: PVInputLocationVC.identifier()) as! PVInputLocationVC
    }
    
    //MARK: - Class Methods
    
    @IBAction func btnSubmitAction(_ sender: Any) {
    }
    
}
