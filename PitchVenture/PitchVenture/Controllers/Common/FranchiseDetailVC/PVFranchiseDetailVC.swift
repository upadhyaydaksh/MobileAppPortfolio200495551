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
    
    @IBOutlet weak var btnApply: PVButton!
    
    var account : Account = Account()
    
    //MARK:- CLASS METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerTableViewCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationTitle("Franchise details")
        setLeftBarButton()
    }
    
    class func instantiate() -> PVFranchiseDetailVC {
        return UIStoryboard.main().instantiateViewController(withIdentifier: PVFranchiseDetailVC.identifier()) as! PVFranchiseDetailVC
    }
    
    func registerTableViewCell() {
        tableView.register(UINib(nibName: "PVImageTableViewCell", bundle: nil), forCellReuseIdentifier: PVImageTableViewCell.reuseIdentifier())
        
        tableView.register(UINib(nibName: "PVFranchiseDetailTableViewCell", bundle: nil), forCellReuseIdentifier: PVFranchiseDetailTableViewCell.reuseIdentifier())
    }
    
    @IBAction func btnApplyAction(_ sender: Any) {
        let obj = PVRequestsVC.instantiate()
        self.push(vc: obj)
    }
}
