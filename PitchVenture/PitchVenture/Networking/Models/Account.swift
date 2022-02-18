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

    init(id: String?, name: String?, email: String?, picture: String?, isComplete: Bool?, isFranchise: Bool?, createdAt: String?, v: Int?, franchise: Franchise?, storeOwner: StoreOwner?) {
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
        }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Account(id : id, name : name, email : email, picture : picture, isComplete : isComplete, isFranchise : isFranchise, createdAt : createdAt, v : v,  franchise : franchise, storeOwner : storeOwner)
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
        name <- map["name"]
        email <- map["email"]
        picture <- map["picture"]
        isComplete <- map["isComplete"]
        isFranchise <- map["isFranchise"]
        createdAt <- map["createdAt"]
        v <- map["v"]
        franchise <- map["franchise"]
        storeOwner <- map["storeOwner"]
    }

    // MARK: NSCoding Protocol

    required public init(coder aDecoder: NSCoder) {


    }

    public func encode(with aCoder: NSCoder) {

    }
}
