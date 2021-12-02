//
//  PVStoreOwnerHomeVC+TableView.swift
//  PitchVenture
//
//  Created by Harshit on 19/11/21.
//  Copyright © 2021 PitchVenture. All rights reserved.
//

import Foundation
import UIKit

extension PVStoreOwnerHomeVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: PVHomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: PVHomeTableViewCell.reuseIdentifier()) as! PVHomeTableViewCell
        return cell
    }
    
    
}
