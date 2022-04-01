//
//  Requests.swift
//  PitchVenture
//
//  Created by Daksh Upadhyay on 2022-02-09.
//  Copyright © 2022 PitchVenture. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class Requests: NSObject, Mappable, NSCopying, NSCoding {
    
    // MARK: Properties
    
    var id : String?
    var apartmentNumber : String?
    
    init(id: String?, apartmentNumber: String?) {
        self.id = id
        self.apartmentNumber = apartmentNumber
        
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Requests(id : id, apartmentNumber : apartmentNumber)
    }
    
    override init() {
        self.id = nil
        self.apartmentNumber = nil
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
        id <- map["id"]
        apartmentNumber <- map["apartmentNumber"]
    }
    
    // MARK: NSCoding Protocol
    
    required public init(coder aDecoder: NSCoder) {
        
        
    }

    public func encode(with aCoder: NSCoder) {
        
    }
}
