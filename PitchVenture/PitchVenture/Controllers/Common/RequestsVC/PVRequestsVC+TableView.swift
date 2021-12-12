//
//  PVRequestsVC+TableView.swift
//  PitchVenture
//
//  Created by Harshit on 11/12/21.
//  Copyright © 2021 PitchVenture. All rights reserved.
//

import UIKit

extension PVRequestsVC : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : PVRequestsTableViewCell = tableView.dequeueReusableCell(withIdentifier: PVRequestsTableViewCell.reuseIdentifier()) as! PVRequestsTableViewCell
        
        cell.btnAccept.tag = indexPath.row
        cell.btnAccept.addTarget(self, action: #selector(self.btnAcceptAction), for: .touchUpInside)
        
        cell.btnReject.tag = indexPath.row
        cell.btnReject.addTarget(self, action: #selector(self.btnRejectAction), for: .touchUpInside)
        
        return cell
    }
    
    @objc func btnAcceptAction(_ sender: UIButton!) {
        print(sender.tag)
    }
    
    @objc func btnRejectAction(_ sender: UIButton!) {
        print(sender.tag)
    }
}
