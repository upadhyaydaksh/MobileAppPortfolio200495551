//
//  Account.swift
//  PitchVenture
//
//  Created by Nithaparan Francis on 2022-01-24.
//  Copyright © 2022 PitchVenture. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class Account: NSObject, Mappable, NSCopying, NSCoding {

    var picture: String?
    var id: String?
    var name: String?
    var email: String?
    var isComplete: Bool?
    var isFranchise: Bool?
    var createdAt: String?
    var token: String?
    var refreshToken: String?
    var storeOwner: StoreOwner?
    var franchise: Franchise?
    var v: Int?
    var countryCode: String?
    var phoneNumber: String?
    
    init(id: String?, name: String?, email: String?, picture: String?, isComplete: Bool?, isFranchise: Bool?, createdAt: String?, v: Int?, franchise: Franchise?, storeOwner: StoreOwner?, countryCode: String?, phoneNumber: String?, token: String?) {
            self.id = id
            self.name = name
            self.email = email
            self.picture = picture
            self.isComplete = isComplete
            self.isFranchise = isFranchise
            self.createdAt = createdAt
            self.v = v
            self.franchise = franchise
            self.storeOwner = storeOwner
            self.countryCode = countryCode
            self.phoneNumber = phoneNumber
            self.token = token
        }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Account(id : id, name : name, email : email, picture : picture, isComplete : isComplete, isFranchise : isFranchise, createdAt : createdAt, v : v,  franchise : franchise, storeOwner : storeOwner, countryCode: countryCode, phoneNumber: phoneNumber, token: token)
    }
    
    override init() {
        self.id = nil
        self.name = nil
        self.email = nil
        self.picture = nil
        self.isComplete = nil
        self.isFranchise = nil
        self.createdAt = nil
        self.v = nil
        self.franchise = nil
        self.storeOwner = nil
        self.countryCode = nil
        self.phoneNumber = nil
        self.token = nil
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
        email <- map["email"]
        picture <- map["picture"]
        isComplete <- map["isComplete"]
        isFranchise <- map["isFranchise"]
        createdAt <- map["createdAt"]
        v <- map["v"]
        franchise <- map["franchise"]
        storeOwner <- map["storeOwner"]
        countryCode <- map["countryCode"]
        phoneNumber <- map["phoneNumber"]
        token <- map["token"]
    }

    // MARK: NSCoding Protocol
    
    required public init(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: "_id") as? String
        self.name = aDecoder.decodeObject(forKey: "name") as? String
        self.email = aDecoder.decodeObject(forKey: "email") as? String
        self.picture = aDecoder.decodeObject(forKey: "picture") as? String
        self.isComplete = aDecoder.decodeObject(forKey: "isComplete") as? Bool
        self.isFranchise = aDecoder.decodeObject(forKey: "isFranchise") as? Bool
        self.createdAt = aDecoder.decodeObject(forKey: "createdAt") as? String
        self.v = aDecoder.decodeObject(forKey: "v") as? Int
        self.franchise = aDecoder.decodeObject(forKey: "franchise") as? Franchise
        self.storeOwner = aDecoder.decodeObject(forKey: "storeOwner") as? StoreOwner
        self.countryCode = aDecoder.decodeObject(forKey: "countryCode") as? String
        self.phoneNumber = aDecoder.decodeObject(forKey: "phoneNumber") as? String
        self.token = aDecoder.decodeObject(forKey: "token") as? String
        
    }

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "_id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(picture, forKey: "picture")
        aCoder.encode(isComplete, forKey: "isComplete")
        aCoder.encode(isFranchise, forKey: "isFranchise")
        aCoder.encode(createdAt, forKey: "createdAt")
        aCoder.encode(v, forKey: "v")
        aCoder.encode(franchise, forKey: "franchise")
        aCoder.encode(storeOwner, forKey: "storeOwner")
        aCoder.encode(countryCode, forKey: "countryCode")
        aCoder.encode(phoneNumber, forKey: "phoneNumber")
        aCoder.encode(token, forKey: "token")
    }
}
