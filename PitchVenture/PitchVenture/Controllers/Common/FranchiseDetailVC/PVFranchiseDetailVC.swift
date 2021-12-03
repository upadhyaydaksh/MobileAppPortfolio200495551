//
//  PVFranchiseDetailVC.swift
//  PitchVenture
//
//  Created by Harshit on 25/11/21.
//  Copyright © 2021 PitchVenture. All rights reserved.
//

import UIKit

class PVFranchiseDetailVC: PVBaseVC {

    //MARK:- VARIABLES
    
    //MARK:- OUTLETS
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- CLASS METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerTableViewCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationTitle("Franchise detail")
        setLeftBarButton()
    }
    
    class func instantiate() -> PVFranchiseDetailVC {
        return UIStoryboard.main().instantiateViewController(withIdentifier: PVFranchiseDetailVC.identifier()) as! PVFranchiseDetailVC
    }
    
    func registerTableViewCell() {
        tableView.register(UINib(nibName: "PVImageTableViewCell", bundle: nil), forCellReuseIdentifier: PVImageTableViewCell.reuseIdentifier())
        
        tableView.register(UINib(nibName: "PVFranchiseDetailTableViewCell", bundle: nil), forCellReuseIdentifier: PVFranchiseDetailTableViewCell.reuseIdentifier())
    }
}
