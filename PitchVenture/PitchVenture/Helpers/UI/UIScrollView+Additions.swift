//
//  UIScrollView+Additions.swift
//  BodyFixers
//
//  Created by Hemant Sharma on 29/06/17.
//  Copyright © 2019 PHYX. All rights reserved.
//

import UIKit
import LGRefreshView

extension UIScrollView {
    
    // Scroll to a specific view so that it's top is at the top our scrollview
    func scrollToView(view:UIView, animated: Bool) {
        if let origin = view.superview {
            // Get the Y position of your child view
            let childStartPoint = origin.convert(view.frame.origin, to: self)
            // Scroll to a rectangle starting at the Y of your subview, with a height of the scrollview
            self.scrollRectToVisible(CGRect(x: childStartPoint.x, y: 0.0, width: self.frame.width, height: self.frame.height), animated: animated)
        }
    }
    
    // Bonus: Scroll to top
    func scrollToTop(animated: Bool) {
        let topOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(topOffset, animated: animated)
    }
    
    // Bonus: Scroll to bottom
    func scrollToBottom() {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        if(bottomOffset.y > 0) {
            setContentOffset(bottomOffset, animated: true)
        }
    }
    
    func addPullToRefresh(_ refresh: @escaping onRefresh) {
        
        let refreshView = LGRefreshView.init(scrollView: self, refreshHandler: { (refreshView: LGRefreshView?) in
            refresh()
        })
        refreshView?.tintColor = Constants.color.kAPP_COLOR
        refreshView?.backgroundColor = Constants.color.kAPP_COLOR
    }
    
}
