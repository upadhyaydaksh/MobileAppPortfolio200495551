//
//  PVHomeVC.swift
//  PitchVenture
//
//  Created by Harshit on 18/11/21.
//  Copyright © 2021 PitchVenture. All rights reserved.
//

import UIKit

class PVHomeVC: PVBaseVC {

    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Class Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerTableViewCell()
    }
    
    class func identifier() -> String {
        return String(describing: self)
    }
    
    class func instantiate() -> PVHomeVC {
        return UIStoryboard.main().instantiateViewController(withIdentifier: PVHomeVC.identifier()) as! PVHomeVC
    }
    
    func registerTableViewCell() {
        tableView.register(UINib(nibName: "PVHomeTableViewCell", bundle: nil), forCellReuseIdentifier: PVHomeTableViewCell.reuseIdentifier())
    }
}
