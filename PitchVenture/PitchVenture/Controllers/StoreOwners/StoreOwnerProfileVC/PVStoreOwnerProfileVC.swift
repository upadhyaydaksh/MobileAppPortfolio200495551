//
//  PVStoreOwnerProfileVC.swift
//  PitchVenture
//
//  Created by Harshit on 25/11/21.
//  Copyright © 2021 PitchVenture. All rights reserved.
//

import UIKit

class PVStoreOwnerProfileVC: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Class Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerTableViewCell()
    }
    
    // MARK: - Class Methods
    
    class func identifier() -> String {
        return String(describing: self)
    }
    
    class func instantiate() -> PVInputLocationVC {
        return UIStoryboard.main().instantiateViewController(withIdentifier: PVInputLocationVC.identifier()) as! PVInputLocationVC
    }
    
    func registerTableViewCell() {
        tableView.register(UINib(nibName: "PVHomeTableViewCell", bundle: nil), forCellReuseIdentifier: PVHomeTableViewCell.reuseIdentifier())
        
        tableView.register(UINib(nibName: "PVTextFieldTableViewCell", bundle: nil), forCellReuseIdentifier: PVTextFieldTableViewCell.reuseIdentifier())
    }
}
