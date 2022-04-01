//
//  PVTextFieldTableViewCell.swift
//  PitchVenture
//
//  Created by Harshit on 25/11/21.
//  Copyright © 2021 PitchVenture. All rights reserved.
//

import UIKit

class PVTextFieldTableViewCell: UITableViewCell {
    
    //MARK:- OUTLETS
    @IBOutlet weak var vwBG: UIView!
    
    @IBOutlet weak var txtValue: PVTextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    class func reuseIdentifier() -> String {
        return String(describing: self)
    }
    
    func configureCell(index: Int, account: Account?) {
        if index == 0 {
            // FULL NAME
            self.txtValue.leftViewImage = UIImage(named: "ic_user")
            self.txtValue.text = account?.name
            self.txtValue.placeholder = "Full Name"
        } else if index == 1 {
            // EMAIL
            self.txtValue.leftViewImage = UIImage(named: "ic_mail")
            self.txtValue.text = account?.email
            self.txtValue.placeholder = "Email"
        } else {
            // PHONE NUMBER
            self.txtValue.leftViewImage = UIImage(named: "ic_phone")
            //"\(account?.storeOwner?.countryCode ?? "+1")" +
            if let isFranchise = account?.isFranchise, isFranchise {
                self.txtValue.text = "\(account?.franchise?.phoneNumber ?? "")"
            } else {
                self.txtValue.text = "\(account?.storeOwner?.phoneNumber ?? "")"
            }
            
            self.txtValue.placeholder = "Phone Number"
        }
    }
}
