//
//  StoreOwner.swift
//  PitchVenture
//
//  Created by Daksh Upadhyay on 2022-02-09.
//  Copyright © 2022 PitchVenture. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class StoreOwner: NSObject, Mappable, NSCopying, NSCoding {

    // MARK: Properties

    var id : String?
    var apartmentNumber : String?
    var addressLine1 : String?
    var addressLine2 : String?
    var city : String?
    var province : String?
    var postalCode: String?
    var sentRequests : [Requests]?
    var acceptedRequests : [Requests]?
    var pictures : [String]?
    var v : Int?
    var countryCode: String?
    var phoneNumber: String?
    
    init(id: String?, apartmentNumber: String?, addressLine1: String?, addressLine2: String?, city: String?, province : String?, postalCode: String?, sentRequests : [Requests]?, acceptedRequests : [Requests]?, pictures: [String]?, v: Int?, countryCode: String?, phoneNumber: String?) {
        self.id = id
        self.apartmentNumber = apartmentNumber
        self.addressLine1 = addressLine1
        self.addressLine2 = addressLine2
        self.city = city
        self.province = province
        self.postalCode = postalCode
        self.sentRequests = sentRequests
        self.acceptedRequests = acceptedRequests
        self.pictures = pictures
        self.v = v
        self.countryCode = countryCode
        self.phoneNumber = phoneNumber

    }

    func copy(with zone: NSZone? = nil) -> Any {
        return StoreOwner(id : id, apartmentNumber : apartmentNumber, addressLine1 : addressLine1, addressLine2 : addressLine2, city : city, province : province, postalCode : postalCode, sentRequests : sentRequests, acceptedRequests : acceptedRequests, pictures : pictures, v : v, countryCode: countryCode, phoneNumber: phoneNumber)
    }

    override init() {
        self.id = nil
        self.apartmentNumber = nil
        self.addressLine1 = nil
        self.addressLine2 = nil
        self.city = nil
        self.province = nil
        self.postalCode = nil
        self.sentRequests = []
        self.acceptedRequests = []
        self.pictures = []
        self.v = nil
        self.countryCode = nil
        self.phoneNumber = nil
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
        addressLine1 <- map["addressLine1"]
        addressLine2 <- map["addressLine2"]
        city <- map["city"]
        province <- map["province"]
        postalCode <- map["postalCode"]
        sentRequests <- map["sentRequests"]
        acceptedRequests <- map["acceptedRequests"]
        pictures <- map["pictures"]
        v <- map["v"]
        countryCode <- map["countryCode"]
        phoneNumber <- map["phoneNumber"]
    }

    // MARK: NSCoding Protocol

    required public init(coder aDecoder: NSCoder) {


    }

    public func encode(with aCoder: NSCoder) {

    }
    
    func getCompleteAddress() -> String {
        //let address = "\(self.addressLine1 ?? "") \(self.addressLine2 ?? "") \(self.city ?? ""), \(self.province ?? "")"
        let address = "\(self.addressLine1 ?? "") \(self.addressLine2 ?? "") "
        return address
    }
}
