//
//  PVStoreOwnerProfileVC.swift
//  PitchVenture
//
//  Created by Harshit on 25/11/21.
//  Copyright © 2021 PitchVenture. All rights reserved.
//

import UIKit

class PVStoreOwnerProfileVC: PVBaseVC {

    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Class Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerTableViewCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setLeftBarButton()
        self.setNavigationTitle("Profile")
    }
    // MARK: - Class Methods
    
    class func instantiate() -> PVStoreOwnerProfileVC {
        return UIStoryboard.main().instantiateViewController(withIdentifier: PVStoreOwnerProfileVC.identifier()) as! PVStoreOwnerProfileVC
    }
    
    func registerTableViewCell() {
        tableView.register(UINib(nibName: "PVHomeTableViewCell", bundle: nil), forCellReuseIdentifier: PVHomeTableViewCell.reuseIdentifier())
        
        tableView.register(UINib(nibName: "PVTextFieldTableViewCell", bundle: nil), forCellReuseIdentifier: PVTextFieldTableViewCell.reuseIdentifier())
    }
}
