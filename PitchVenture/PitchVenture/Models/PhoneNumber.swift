//
//  PhoneNumber.swift
//  BodyFixers
//
//  Created by Hemant Sharma on 09/08/19.
//  Copyright © 2019 PHYX. All rights reserved.
//

import UIKit
import ObjectMapper

class PhoneNumber: NSObject, Mappable, NSCoding {
    
    // MARK: Properties
    public var label: String?
    public var countryCode: String?
    public var phone: String?
    
    init(label: String? = "home", countryCode: String?, phone: String?) {
        self.label = label
        self.countryCode = countryCode
        self.phone = phone
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
        countryCode <- map["countryCode"]
        phone <- map["phone"]
    }
    
    // MARK: NSCoding Protocol
    
    required public init(coder aDecoder: NSCoder) {
        self.label = aDecoder.decodeObject(forKey: "label") as? String
        self.countryCode = aDecoder.decodeObject(forKey: "countryCode") as? String
        self.phone = aDecoder.decodeObject(forKey: "phone") as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(label, forKey: "label")
        aCoder.encode(countryCode, forKey: "countryCode")
        aCoder.encode(phone, forKey: "phone")
    }

    func fullPhoneNumber() -> String {
        return "\(countryCode.safeString())\(phone.safeString())"
    }
}
