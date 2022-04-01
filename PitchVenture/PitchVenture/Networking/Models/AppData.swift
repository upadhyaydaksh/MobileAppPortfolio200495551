//
//  AppData.swift
//  PitchVenture
//
//  Created by Daksh Upadhyay on 2022-02-22.
//  Copyright © 2022 PitchVenture. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class AppData: NSObject, Mappable, NSCopying, NSCoding {
    
    // MARK: Properties
    
    var id : String?
    var name : String?
    
    init(id: String?, name: String?) {
        self.id = id
        self.name = name
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return AppData(id : id, name : name)
    }
    
    override init() {
        self.id = nil
        self.name = nil
    }
    
    // MARK: ObjectMapper Initalizers
    /**
     Map a JSON object to this class using ObjectMapper
     - parameter map: A mapping from ObjectMapper
     */
    required public init?(map: Map){
        
    }
    
    /**
     Map a JSON object to this class using ObjectMapper
     - parameter map: A mapping from ObjectMapper
     */
    public func mapping(map: Map) {
        id <- map["_id"]
        name <- map["name"]
    }
    
    // MARK: NSCoding Protocol
    
    required public init(coder aDecoder: NSCoder) {
        
        
    }

    public func encode(with aCoder: NSCoder) {
        
    }
    
    func convertIntToCurrencyAsString(intValue: Int) -> String {
        var stringVersion: String
        let cFormatter = NumberFormatter()
        cFormatter.usesGroupingSeparator = true
        cFormatter.numberStyle = .currency
        if let currencyString = cFormatter.string(from: NSNumber(value: intValue)) {
            stringVersion = currencyString
        } else {
            stringVersion = "Invalid Message"
        }
        return stringVersion
    }
}
