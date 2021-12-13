//
//  User.swift
//  BodyFixers
//
//  Created by Hemant Sharma on 30/06/17.
//  Copyright © 2019 PHYX. All rights reserved.
//

import UIKit
import ObjectMapper

enum UserLoginType: Int {
    case StoreOwner = 1
    case Franchisor = 2
}

enum AcceptDecline : String {
    case Accept = "Accept"
    case Decline = "Decline"
}

enum Gender : Int {
    case Male = 1
    case Female = 2
    case Both = 3
}

class User: NSObject, Mappable, NSCopying, NSCoding {
    
    // MARK: Properties
    
    var id: String?
    var fullName: String?
    var phoneNumber: PhoneNumber?
    var deviceInfo: DeviceInfo?
    var appInfo: AppInfo?
    var profilePicture: String?
    var gender: Gender?
    var address: Address?
    var dob: String?
    var accessToken: String?
    var pushToken: String?
    
    init(id: String?, fullName: String?, phoneNumber: PhoneNumber?, deviceInfo: DeviceInfo?, appInfo: AppInfo?, profilePicture: String?, gender: Gender?, address: Address?, dob: String?, accessToken: String?, pushToken: String?) {
        self.id = id
        self.fullName = fullName
        self.phoneNumber = phoneNumber
        self.accessToken = accessToken
        self.deviceInfo = deviceInfo
        self.appInfo = appInfo
        self.profilePicture = profilePicture
        self.gender = gender
        self.address = address
        self.dob = dob
        self.accessToken = accessToken
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return User(id: id, fullName: fullName, phoneNumber: phoneNumber, deviceInfo: deviceInfo, appInfo: appInfo, profilePicture: profilePicture, gender: gender, address: address, dob: dob, accessToken: accessToken, pushToken: pushToken)
    }
    
    override init() {
        self.id = nil
        self.fullName = nil
        self.phoneNumber = nil
        self.accessToken = nil
        self.deviceInfo = nil
        self.appInfo = nil
        self.profilePicture = nil
        self.gender = nil
        self.address = nil
        self.dob = nil
        self.accessToken = nil
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
        fullName <- map["fullName"]
        phoneNumber <- map["phoneNumber"]
        accessToken <- map["accessToken"]
        deviceInfo <- map["deviceInfo"]
        appInfo <- map["appInfo"]
        
        var imageName: String?
        imageName <- map["profilePicture"]
        //profilePicture = Constants.imageURL(imageName, .user)
        
        gender <- (map["gender"],EnumTransform<Gender>())
        address <- map["fullAddress"]
        dob <- map["dob"]
        pushToken <- map["pushToken"]
    }
    
    // MARK: NSCoding Protocol
    
    required public init(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: "_id") as? String
        self.fullName = aDecoder.decodeObject(forKey: "fullName") as? String
        self.phoneNumber = aDecoder.decodeObject(forKey: "phoneNumber") as? PhoneNumber
        self.accessToken = aDecoder.decodeObject(forKey: "accessToken") as? String
        self.deviceInfo = aDecoder.decodeObject(forKey: "deviceInfo") as? DeviceInfo
        self.appInfo = aDecoder.decodeObject(forKey: "appInfo") as? AppInfo
        self.profilePicture = aDecoder.decodeObject(forKey: "profilePicture") as? String
        
        if let decoded = aDecoder.decodeObject(forKey: "gender") as? Int {
            self.gender = Gender(rawValue: decoded)
        }
        
        self.address = aDecoder.decodeObject(forKey: "fullAddress") as? Address
        self.dob = aDecoder.decodeObject(forKey: "dob") as? String
        self.pushToken = aDecoder.decodeObject(forKey: "pushToken") as? String
    }

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "_id")
        aCoder.encode(fullName, forKey: "fullName")
        aCoder.encode(phoneNumber, forKey: "phoneNumber")
        aCoder.encode(accessToken, forKey: "accessToken")
        aCoder.encode(deviceInfo, forKey: "deviceInfo")
        aCoder.encode(appInfo, forKey: "appInfo")
        aCoder.encode(profilePicture, forKey: "profilePicture")
        aCoder.encode(gender?.rawValue, forKey: "gender")
        aCoder.encode(address, forKey: "fullAddress")
        aCoder.encode(dob, forKey: "dob")
        aCoder.encode(pushToken, forKey: "pushToken")
    }
}

