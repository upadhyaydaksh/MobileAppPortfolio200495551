//
//  PVHomeTableViewCell.swift
//  PitchVenture
//
//  Created by Harshit on 19/11/21.
//  Copyright © 2021 PitchVenture. All rights reserved.
//

import UIKit
import SDWebImage

class PVHomeTableViewCell: UITableViewCell {

    @IBOutlet weak var imgFranchise: PVImageView!
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblCategory: UILabel!
    
    @IBOutlet weak var lblDeposit: UILabel!
    
    @IBOutlet weak var lblMinimumDeposit: UILabel!
    
    @IBOutlet weak var btnFranchise: PVButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class func reuseIdentifier() -> String {
        return String(describing: self)
    }
    
    func configureFranchiseCell(account: Account?, isEditHidden: Bool) {
        self.lblName.text = account?.franchise?.franchiseName
        self.lblDeposit.text = "Minimum deposit:"
        self.lblMinimumDeposit.text = account?.franchise?.convertIntToCurrencyAsString(intValue: account?.franchise?.minimumDeposit ?? 0)
        self.btnFranchise.isHidden = isEditHidden
        self.btnFranchise.setTitle("Edit", for: .normal)
        if let account = account, account.isFranchise ?? false  {
            if let picture = account.picture {
                self.imgFranchise.sd_setImage(with: URL(string: picture), placeholderImage: UIImage(named: "ic_logo.png"))
            }
        } 
    }
    
    func configureStoreOwnerCell(account: Account?, isEditHidden: Bool) {
        self.lblName.text = account?.name
        self.lblCategory.text = account?.storeOwner?.getCompleteAddress()
        self.lblDeposit.text = "City"
        self.lblMinimumDeposit.text = account?.storeOwner?.city
        if let pictures = account?.storeOwner?.pictures, pictures.count > 0 {
            self.imgFranchise.sd_setImage(with: URL(string: account?.storeOwner?.pictures?[0] ?? ""), placeholderImage: UIImage(named: "ic_logo.png"))
        }
        
    }
    
}
