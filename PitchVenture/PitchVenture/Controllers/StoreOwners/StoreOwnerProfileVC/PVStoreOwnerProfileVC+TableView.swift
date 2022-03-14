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
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else if section == 1 {
            return 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: PVTextFieldTableViewCell = tableView.dequeueReusableCell(withIdentifier: PVTextFieldTableViewCell.reuseIdentifier()) as! PVTextFieldTableViewCell
            cell.configureCell(index: indexPath.row, account: self.account)
            return cell
        } else if indexPath.section == 1 {
            let cell: PVButtonTableViewCell = tableView.dequeueReusableCell(withIdentifier: PVButtonTableViewCell.reuseIdentifier()) as! PVButtonTableViewCell
            cell.btnSubmit.addTarget(self, action: #selector(self.btnUpdateAction), for: .touchUpInside)
            return cell
        } else {
            let cell: PVHomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: PVHomeTableViewCell.reuseIdentifier()) as! PVHomeTableViewCell
            cell.configureStoreOwnerCell(account: self.account)
            cell.btnFranchise.setTitle("Edit", for: .normal)
            cell.btnFranchise.addTarget(self, action: #selector(btnEditProfileAction(sender:)), for: .touchUpInside)

            return cell
        }
    }
    
    @objc func btnUpdateAction(sender: UIButton){
        var parameters = [String: Any]()
        parameters = [
            "accountId": self.account.id!,
            "name": self.account.name?.trimmedString() ?? "",
            "email": self.account.email?.trimmedString() ?? "",
            "countryCode": "+1",
            "phoneNumber": "2493597231"
        ]
        
        if self.isFormValid() {
            self.storeOwenerUpdate(parameters: parameters)
        } else {
            self.showAlertWithMessage(msg: "Please enter all details.")
        }
    }
    
    @objc func btnEditProfileAction(sender: UIButton){
        
        if self.account.isFranchise! {
            let obj = PVFranchisorsSignupVC.instantiate()
            obj.account = self.account
            obj.isFromEditProfile = true
            self.push(vc: obj)
        } else {
            let obj = PVInputLocationVC.instantiate()
            obj.account = self.account
            obj.isFromEditProfile = true
            self.push(vc: obj)
        }
    }
    
    func isFormValid() -> Bool{
        if let name = self.account.name, name.trimmedString().isEmpty {
            self.showAlertWithMessage(msg: "Please enter your full name")
            return false
        }
        if let email = self.account.email, email.trimmedString().isEmpty {
            self.showAlertWithMessage(msg: "Please enter your email address")
            return false
        }
        
        return true
    }
}
