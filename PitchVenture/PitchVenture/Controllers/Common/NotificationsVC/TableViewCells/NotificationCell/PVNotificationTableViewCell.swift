//
//  PVNotificationTableViewCell.swift
//  PitchVenture
//
//  Created by Harshit on 11/12/21.
//  Copyright © 2021 PitchVenture. All rights reserved.
//

import UIKit

class PVNotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblDateTime: UILabel!
    
    @IBOutlet weak var vwSeperator: UIView!
    
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
    
    func configureCellForAuctionURL(url: String) {
        lblTitle.text = url
    }
}
