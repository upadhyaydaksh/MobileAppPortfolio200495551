//
//  PVFranchiseDetailTableViewCell.swift
//  PitchVenture
//
//  Created by Harshit on 25/11/21.
//  Copyright © 2021 PitchVenture. All rights reserved.
//

import UIKit

class PVFranchiseDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var lblFranchiseCategory: UILabel!
    
    @IBOutlet weak var lblFranchiseName: UILabel!
    
    @IBOutlet weak var lblFranchiseDescription: UILabel!
    
    @IBOutlet weak var lblFranchiseDeposit: UILabel!
    
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
    
    func configureFranchiseCell(account: Account?) {
        self.lblFranchiseName.text = account?.franchise?.franchiseName
        self.lblFranchiseDescription.text = account?.franchise?.franchiseName
        
        if let category = account?.franchise?.franchiseCategory, category.count > 0 {
            self.lblFranchiseCategory.text = account?.franchise?.franchiseCategoryName
        }
        
        self.lblFranchiseDeposit.text = account?.franchise?.convertIntToCurrencyAsString(intValue: account?.franchise?.minimumDeposit ?? 0)

    }
    
    func configureStoreOwnerCell(account: Account?) {
        self.lblFranchiseName.text = account?.name
        self.lblFranchiseDescription.text = account?.storeOwner?.getCompleteAddress()
        self.lblFranchiseCategory.text = "City"
        self.lblFranchiseDeposit.text = account?.storeOwner?.city
    }
    
}
