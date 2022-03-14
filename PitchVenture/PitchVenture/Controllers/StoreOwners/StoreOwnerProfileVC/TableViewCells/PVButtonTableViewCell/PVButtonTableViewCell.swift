//
//  PVButtonTableViewCell.swift
//  PitchVenture
//
//  Created by Daksh Upadhyay on 2022-03-13.
//  Copyright © 2022 PitchVenture. All rights reserved.
//

import UIKit

class PVButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var btnSubmit: PVButton!
    
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
    
}
