//
//  PVHeaderFooterView.swift
//  PitchVenture
//
//  Created by Harshit on 11/12/21.
//  Copyright © 2021 PitchVenture. All rights reserved.
//

import UIKit

class PVHeaderFooterView: UITableViewHeaderFooterView {

    @IBOutlet weak var lblTitle: UILabel!
    
    class func reuseIdentifier() -> String {
        return String(describing: self)
    }
    
    func configureView(title: String?) {
        lblTitle.text = title
    }
}
