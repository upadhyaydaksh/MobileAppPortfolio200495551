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
    var franchiseDescription : String?
    var minimumDeposit : Int?
    var franchiseCategory : [String] = []
    var countryCode: String?
    var phoneNumber: String?
    var pictures : [String] = []
    
    init(id: String?, franchiseName: String?,franchiseDescription: String?, minimumDeposit: Int?, franchiseCategory: [String], countryCode: String?, phoneNumber: String?, pictures: [String]) {
        self.id = id
        self.franchiseName = franchiseName
        self.franchiseDescription = franchiseDescription
        self.minimumDeposit = minimumDeposit
        self.franchiseCategory = franchiseCategory
        self.countryCode = countryCode
        self.phoneNumber = phoneNumber
        self.pictures = pictures
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Franchise(id : id, franchiseName : franchiseName, franchiseDescription: franchiseDescription, minimumDeposit: minimumDeposit, franchiseCategory: franchiseCategory, countryCode: countryCode, phoneNumber: phoneNumber, pictures : pictures)
    }
    
    override init() {
        self.id = nil
        self.franchiseName = nil
        self.franchiseDescription = nil
        self.minimumDeposit = nil
        self.franchiseCategory = []
        self.countryCode = nil
        self.phoneNumber = nil
        self.pictures = []
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
        franchiseDescription <- map["franchiseDescription"]
        minimumDeposit <- map["minimumDeposit"]
        franchiseCategory <- map["franchiseCategory"]
        countryCode <- map["countryCode"]
        phoneNumber <- map["phoneNumber"]
        pictures <- map["pictures"]
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
