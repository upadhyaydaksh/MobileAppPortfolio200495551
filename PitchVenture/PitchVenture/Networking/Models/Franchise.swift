//
//  Franchise.swift
//  PitchVenture
//
//  Created by Daksh Upadhyay on 2022-02-09.
//  Copyright © 2022 PitchVenture. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class Franchise: NSObject, Mappable, NSCopying, NSCoding {
    
    // MARK: Properties
    
    var id : String?
    var franchiseName : String?
    var minimumDeposit : Int?
    var franchiseCategory : [String] = []
    
    init(id: String?, franchiseName: String?, minimumDeposit: Int?, franchiseCategory: [String]) {
        self.id = id
        self.franchiseName = franchiseName
        self.minimumDeposit = minimumDeposit
        self.franchiseCategory = franchiseCategory
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Franchise(id : id, franchiseName : franchiseName, minimumDeposit: minimumDeposit, franchiseCategory: franchiseCategory)
    }
    
    override init() {
        self.id = nil
        self.franchiseName = nil
        self.minimumDeposit = nil
        self.franchiseCategory = []
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
        franchiseName <- map["franchiseName"]
        minimumDeposit <- map["minimumDeposit"]
        franchiseCategory <- map["franchiseCategory"]
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
