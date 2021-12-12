//
//  PVRequestsTableViewCell.swift
//  PitchVenture
//
//  Created by Harshit on 11/12/21.
//  Copyright © 2021 PitchVenture. All rights reserved.
//

import UIKit

class PVRequestsTableViewCell: UITableViewCell {

    @IBOutlet weak var imgvLogo: PVImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCompanyName: UILabel!
    
    @IBOutlet weak var btnReject: UIButton!
    @IBOutlet weak var btnAccept: UIButton!
    
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
    
    func configureCell(url: String) {
        lblName.text = url
    }
    
}
