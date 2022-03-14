//
//  PVStoreOwnerHomeVC+TableView.swift
//  PitchVenture
//
//  Created by Harshit on 19/11/21.
//  Copyright © 2021 PitchVenture. All rights reserved.
//

import Foundation
import UIKit

extension PVStoreOwnerHomeVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrFranchises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: PVHomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: PVHomeTableViewCell.reuseIdentifier()) as! PVHomeTableViewCell
        //cell.configureFranchiseCell(franchise: self.arrFranchises[indexPath.row].franchise)
        cell.configureStoreOwnerCell(account: self.arrFranchises[indexPath.row])
        cell.btnFranchise.setTitle("Apply", for: .normal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = PVFranchiseDetailVC.instantiate()
        self.push(vc: obj)
    }
    
    
}
