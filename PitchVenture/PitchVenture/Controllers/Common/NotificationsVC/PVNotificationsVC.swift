//
//  PVNotificationsVC.swift
//  PitchVenture
//
//  Created by Harshit on 11/12/21.
//  Copyright © 2021 PitchVenture. All rights reserved.
//

import UIKit

class PVNotificationsVC: PVBaseVC {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerTableViewCells()
        self.registerHeaderFooterViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationTitle("Notifications")
        setLeftBarButton()
    }
    
    class func instantiate() -> PVNotificationsVC {
        return UIStoryboard.main().instantiateViewController(withIdentifier: PVNotificationsVC.identifier()) as! PVNotificationsVC
    }
    
    func registerHeaderFooterViews() {
        tableView.register(UINib(nibName: "PVHeaderFooterView", bundle: nil), forHeaderFooterViewReuseIdentifier: PVHeaderFooterView.reuseIdentifier())
    }
    
    func registerTableViewCells() {
    //TABLEVIEW CELLS
        tableView.register(UINib(nibName: "PVNotificationTableViewCell", bundle: nil), forCellReuseIdentifier: PVNotificationTableViewCell.reuseIdentifier())
    }
}
