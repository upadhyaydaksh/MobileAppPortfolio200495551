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
    
}
