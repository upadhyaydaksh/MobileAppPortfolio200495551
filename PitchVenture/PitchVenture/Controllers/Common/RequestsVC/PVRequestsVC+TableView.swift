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
        return self.arrFranchises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : PVRequestsTableViewCell = tableView.dequeueReusableCell(withIdentifier: PVRequestsTableViewCell.reuseIdentifier()) as! PVRequestsTableViewCell
        
        if self.btnSegmentedControl.selectedSegmentIndex == 0 {
            cell.btnAccept.isHidden = false
            cell.btnAccept.tag = indexPath.row
            cell.btnAccept.addTarget(self, action: #selector(self.btnAcceptAction), for: .touchUpInside)
            
            cell.btnReject.isHidden = false
            cell.btnReject.tag = indexPath.row
            cell.btnReject.addTarget(self, action: #selector(self.btnRejectAction), for: .touchUpInside)
            
        } else {
            cell.btnAccept.isHidden = true
            cell.btnReject.isHidden = true
        }
        
        cell.configureCell(account: self.arrFranchises[indexPath.row])
        return cell
    }
    
    @objc func btnAcceptAction(_ sender: UIButton!) {
        print(sender.tag)
        let alert = UIAlertController(title: "Accept Request", message: "Are you sure you want to Accept request?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Accept", style: .default, handler: { (_) in
            //ACCEPT REQUEST
            self.acceptRequest(account: self.arrFranchises[sender.tag])
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func btnRejectAction(_ sender: UIButton!) {
        print(sender.tag)
        let alert = UIAlertController(title: "Reject Request", message: "Are you sure you want to Reject request?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Reject", style: .default, handler: { (_) in
            //Reject REQUEST
            self.rejectRequest(account: self.arrFranchises[sender.tag])
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
