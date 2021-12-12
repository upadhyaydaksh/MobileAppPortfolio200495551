//
//  PVNotificaationsVC+TableView.swift
//  PitchVenture
//
//  Created by Harshit on 11/12/21.
//  Copyright © 2021 PitchVenture. All rights reserved.
//

import UIKit

extension PVNotificationsVC : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : PVNotificationTableViewCell = tableView.dequeueReusableCell(withIdentifier: PVNotificationTableViewCell.reuseIdentifier()) as! PVNotificationTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vw = tableView.dequeueReusableHeaderFooterView(withIdentifier: PVHeaderFooterView.reuseIdentifier()) as! PVHeaderFooterView
        var title = ""
        
        if section == 0 {
            title = "New Notifications"
        } else {
            title = "Previous Notifications"
        }
        
        vw.configureView(title: title)
        return vw
    }
    
}


