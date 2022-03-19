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
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return 1
        } else {
            
            //HIDE REQUEST BUTTON FOR STORE OWNERS
            if let isFranchise = self.account.isFranchise, isFranchise {
                return 1
            } else {
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: PVTextFieldTableViewCell = tableView.dequeueReusableCell(withIdentifier: PVTextFieldTableViewCell.reuseIdentifier()) as! PVTextFieldTableViewCell
            
            cell.txtValue.tag = indexPath.row
            cell.txtValue.delegate = self
            
            cell.configureCell(index: indexPath.row, account: self.account)
            return cell
        } else if indexPath.section == 1 {
            let cell: PVButtonTableViewCell = tableView.dequeueReusableCell(withIdentifier: PVButtonTableViewCell.reuseIdentifier()) as! PVButtonTableViewCell
            cell.btnSubmit.tag = 1
            cell.btnSubmit.setTitle("Update", for: .normal)
            cell.btnSubmit.addTarget(self, action: #selector(self.btnUpdateAction), for: .touchUpInside)
            return cell
        } else if indexPath.section == 2 {
            let cell: PVHomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: PVHomeTableViewCell.reuseIdentifier()) as! PVHomeTableViewCell
            if let isFranchise = self.account.isFranchise, isFranchise {
                //FRANCHISE
                cell.configureFranchiseCell(account: self.account, isEditHidden: false)
                for i in 0 ..< self.arrAppData.count {
                    if self.arrAppData[i].id == self.account.franchise?.franchiseCategory.first {
                        cell.lblCategory.text = self.arrAppData[i].name
                        break
                    }
                }
            } else {
                cell.configureStoreOwnerCell(account: self.account, isEditHidden: false)
            }
            
            cell.btnFranchise.setTitle("Edit", for: .normal)
            cell.btnFranchise.addTarget(self, action: #selector(btnEditProfileAction), for: .touchUpInside)

            return cell
        } else {
            let cell: PVButtonTableViewCell = tableView.dequeueReusableCell(withIdentifier: PVButtonTableViewCell.reuseIdentifier()) as! PVButtonTableViewCell
            cell.btnSubmit.tag = 3
            cell.btnSubmit.setTitle("  Manage Your Requests  ", for: .normal)
            cell.btnSubmit.addTarget(self, action: #selector(self.btnRequestsAction(sender:)), for: .touchUpInside)
            return cell
        }
    }
    
    @objc func btnRequestsAction(sender: UIButton) {
        
        if sender.tag == 3 {
            let obj = PVRequestsVC.instantiate()
            obj.account = self.account
            self.push(vc: obj)
        }
    }
    
    @objc func btnUpdateAction(sender: UIButton){
        
        if sender.tag == 1 && sender.currentTitle == "Update"{
            self.view.endEditing(true)
            
            if self.isFormValid() {
                if let isFranchise = self.account.isFranchise, isFranchise {
                    //UPDATE PROFILE OF FRANCHISOR
                    
                    var parameters = [String: Any]()
                    parameters = [
                        "accountId": self.account.id!,
                        "name": self.account.name?.trimmedString() ?? "",
                        "email": self.account.email?.trimmedString() ?? "",
                        "countryCode": self.account.franchise?.countryCode ?? "",
                        "phoneNumber": self.account.franchise?.phoneNumber ?? ""
                    ]
                    
                    print(parameters)
                    
                    self.franchisorUpdate(parameters: parameters)
                } else {
                    //UPDATE PROFILE OF STORE OWNER
                    var parameters = [String: Any]()
                    parameters = [
                        "accountId": self.account.id!,
                        "name": self.account.name?.trimmedString() ?? "",
                        "email": self.account.email?.trimmedString() ?? "",
                        "countryCode": self.account.storeOwner?.countryCode ?? "",
                        "phoneNumber": self.account.storeOwner?.phoneNumber ?? ""
                    ]
                    
                    print(parameters)
                    self.storeOwenerUpdate(parameters: parameters)
                }
            } else {
                self.showAlertWithMessage(msg: "Please enter all details.")
            }
        }
    }
    
    @objc func btnEditProfileAction(sender: UIButton){
        
        if self.account.isFranchise! {
            let obj = PVFranchisorsSignupVC.instantiate()
            obj.account = self.account
            obj.arrAppData = self.arrAppData
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
        
        if let isFranchise = self.account.isFranchise, isFranchise {
            if let phone = self.account.franchise?.phoneNumber, phone.isEmpty || phone.length() != 10 {
                self.showAlertWithMessage(msg: "Please enter valid phone number. Phone number should be of 10 characters")
                return false
            }
        } else {
            if let phone = self.account.storeOwner?.phoneNumber, phone.isEmpty || phone.length() != 10  {
                self.showAlertWithMessage(msg: "Please enter valid phone number. Phone number should be of 10 characters")
                return false
            }
        }
        
        return true
    }
}

extension PVStoreOwnerProfileVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 0 {
            //NAME
            self.account.name = textField.text
        } else if textField.tag == 1 {
            //EMAIL
            self.account.email = textField.text
        } else {
            //PHONE
            if let isFranchise = self.account.isFranchise, isFranchise {
                self.account.franchise?.phoneNumber = textField.text
            } else {
                self.account.storeOwner?.phoneNumber = textField.text
            }
        }
        return true
    }
}
