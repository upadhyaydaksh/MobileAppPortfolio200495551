//
//  Dictionary+Request.swift
//  BodyFixers
//
//  Created by Hemant Sharma on 14/07/17.
//  Copyright © 2019 PHYX. All rights reserved.
//

import UIKit

extension Dictionary {
    
    mutating func merge(with dictionary: Dictionary) {
        dictionary.forEach { updateValue($1, forKey: $0) }
    }
    
}
