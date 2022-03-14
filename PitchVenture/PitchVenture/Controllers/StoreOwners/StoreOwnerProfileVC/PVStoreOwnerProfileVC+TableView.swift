//
//  PVStoreOwnerProfileVC+.swift
//  PitchVenture
//
//  Created by Harshit on 25/11/21.
//  Copyright © 2021 PitchVenture. All rights reserved.
//

import Foundation
import UIKit

extension PVStoreOwnerProfileVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: PVTextFieldTableViewCell = tableView.dequeueReusableCell(withIdentifier: PVTextFieldTableViewCell.reuseIdentifier()) as! PVTextFieldTableViewCell
            cell.configureCell(index: indexPath.row, account: self.account)
            return cell
        } else {
            let cell: PVHomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: PVHomeTableViewCell.reuseIdentifier()) as! PVHomeTableViewCell
            cell.configureStoreOwnerCell(account: self.account)
            cell.btnFranchise.setTitle("Edit", for: .normal)
            cell.btnFranchise.addTarget(self, action: #selector(btnEditProfileAction(sender:)), for: .touchUpInside)

            return cell
        }
    }
    
    @objc func btnEditProfileAction(sender: UIButton){
        let obj = PVInputLocationVC.instantiate()
        obj.account = self.account
        obj.isFromEditProfile = true
        self.push(vc: obj)
    }
}
