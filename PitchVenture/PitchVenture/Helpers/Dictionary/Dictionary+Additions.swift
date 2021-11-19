//
//  Dictionary+Additions.swift
//
//  Created by Geetika Gupta on 31/03/16.
//  Copyright © 2019 PHYX. All rights reserved.
//

import Foundation

// MARK: - Dictionary Extension
internal extension Dictionary {

    func queryItems() -> [URLQueryItem]? {
        if self.keys.count > 0 {
            var items = [URLQueryItem]()
            for key in self.keys {
                if key is String && self[key] is String {
                    items.append(URLQueryItem(name: key as! String, value: self[key] as? String))
                } else {
                    assertionFailure("Key and values should be String type")
                }
            }
            return items
        }
        return nil
    }
}
