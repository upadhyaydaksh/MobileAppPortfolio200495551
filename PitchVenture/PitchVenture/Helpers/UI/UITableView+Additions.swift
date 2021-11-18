//
//  UITableView+Additions.swift
//  BodyFixers
//
//  Created by Hemant Sharma on 28/06/17.
//  Copyright © 2019 PHYX. All rights reserved.
//

import UIKit

extension UITableView
{
    func isFloatingSectionHeader( view:UITableViewHeaderFooterView )->Bool
    {
        if let section = section( forHeader:view )
        {
            return isFloatingHeaderInSection( section:section )
        }
        return false
    }
    
    func isFloatingHeaderInSection( section:Int )->Bool
    {
        let frame = rectForHeader( inSection:section )
        let y = contentInset.top + contentOffset.y
        return y > frame.origin.y
    }
    
    func section( forHeader viewHeader:UITableViewHeaderFooterView )->Int?
    {
        for i in stride( from:0, to:numberOfSections, by:1 )
        {
            let a = convert( CGPoint.zero, from:headerView( forSection:i ) )
            let b = convert( CGPoint.zero, from:viewHeader )
            if Int(a.y) == Int(b.y)
            {
                return i
            }
        }
        return nil
    }
    
    func section( forFooter viewFooter:UITableViewHeaderFooterView )->Int?
    {
        for i in stride( from:0, to:numberOfSections, by:1 )
        {
            let a = convert( CGPoint.zero, from:footerView( forSection:i ) )
            let b = convert( CGPoint.zero, from:viewFooter )
            if Int(a.y) == Int(b.y)
            {
                return i
            }
        }
        return nil
    }
    
    func allCells() -> [UITableViewCell] {
        var cells = [UITableViewCell]()
        for i in 0...self.numberOfSections-1 {
            for j in 0...self.numberOfRows(inSection: i)-1 {
                if let cell = self.cellForRow(at: IndexPath(row: j, section: i)) {
                    cells.append(cell)
                }
            }
        }
        return cells
    }
}
