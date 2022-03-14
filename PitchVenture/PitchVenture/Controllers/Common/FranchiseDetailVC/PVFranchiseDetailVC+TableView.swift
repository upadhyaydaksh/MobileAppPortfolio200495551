//
//  PVFranchiseDetailVC+TableView.swift
//  PitchVenture
//
//  Created by Harshit on 25/11/21.
//  Copyright © 2021 PitchVenture. All rights reserved.
//

import Foundation
import UIKit

extension PVFranchiseDetailVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell: PVImageTableViewCell = tableView.dequeueReusableCell(withIdentifier: PVImageTableViewCell.reuseIdentifier()) as! PVImageTableViewCell
            
            return cell
        } else {
            let cell: PVFranchiseDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: PVFranchiseDetailTableViewCell.reuseIdentifier()) as! PVFranchiseDetailTableViewCell
            cell.configureCell(franchise: self.account.franchise)
            return cell
        }
    }
}
