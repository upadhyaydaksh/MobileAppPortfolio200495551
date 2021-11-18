//
//  FRTableView.swift
//  BodyFixers
//
//  Created by Hemant Sharma on 20/06/17.
//  Copyright © 2019 PHYX. All rights reserved.
//

import UIKit
import LGRefreshView

public typealias onRefresh = (() -> (Void))

class PVTableView: UITableView, UITableViewDelegate {
    
    var customBackgroundView: UIView?
    
    var refreshView: LGRefreshView?
    
    var completionHandler: onRefresh?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.separatorStyle = .none
        self.tableFooterView = UIView(frame: CGRect.zero)
        self.tableHeaderView = UIView(frame: CGRect.zero)
        //self.backgroundColor = Constants.color.kApp_BackgroundColor
        self.backgroundColor = UIColor.clear
    }
    
    func setBackgroundView(view: UIView) {
        self.backgroundView = view
    }
    
    func setNoDataFoundViewText(text: String?) {
        if let titleLabel = self.customBackgroundView?.viewWithTag(10) as? UILabel {
            titleLabel.text = text
        }
    }
    
    func setupPullToRefresh(_ refresh: @escaping onRefresh) {
        
        completionHandler = refresh
        
        refreshView = LGRefreshView.init(scrollView: self, refreshHandler: { (refreshView: LGRefreshView?) in
            self.refreshTableView()
        })
        refreshView?.tintColor = Constants.color.kAPP_COLOR
        refreshView?.backgroundColor = Constants.color.kAPP_COLOR
    }
    
    func refreshTableView() {
        self.completionHandler!()
    }
    
    func stopRefreshing() {
        self.refreshView?.endRefreshing()
    }
    
    // MARK: - Header Settings
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
