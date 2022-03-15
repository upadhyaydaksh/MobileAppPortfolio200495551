//
//  PVRequestsVC.swift
//  PitchVenture
//
//  Created by Harshit on 11/12/21.
//  Copyright © 2021 PitchVenture. All rights reserved.
//

import UIKit

class PVRequestsVC: PVBaseVC {

    @IBOutlet weak var tableView: UITableView!
    
    var account : Account = Account()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerTableViewCells()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationTitle("Requests")
        self.setLeftBarButton()
        if let isFranchise = self.account.isFranchise, isFranchise {
            self.getAllFranchisorsRequests()
        } else {
            self.getAllStoreOwnersRequests()
        }
    }
    
    class func instantiate() -> PVRequestsVC {
        return UIStoryboard.main().instantiateViewController(withIdentifier: PVRequestsVC.identifier()) as! PVRequestsVC
    }
    
    func registerTableViewCells() {
    //TABLEVIEW CELLS
        tableView.register(UINib(nibName: "PVRequestsTableViewCell", bundle: nil), forCellReuseIdentifier: PVRequestsTableViewCell.reuseIdentifier())
    }
}
