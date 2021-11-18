//
//  DeviceInfo.swift
//  BodyFixers
//
//  Created by Hemant Sharma on 30/06/17.
//  Copyright © 2019 PHYX. All rights reserved.
//

import UIKit
import ObjectMapper

class DeviceInfo: NSObject, Mappable, NSCopying, NSCoding {
    
    // MARK: Properties
    public var device: DeviceType?
    public var pushToken: String?

    
    // MARK: ObjectMapper Initalizers
    /**
     Map a JSON object to this class using ObjectMapper
     - parameter map: A mapping from ObjectMapper
     */
    required public init?(map: Map){
        
    }
    
    init(device: DeviceType?, pushToken: String?) {
        self.device = device
        self.pushToken = pushToken
    }
    
    /**
     Map a JSON object to this class using ObjectMapper
     - parameter map: A mapping from ObjectMapper
     */
    public func mapping(map: Map) {
        device <- (map["device"],EnumTransform<DeviceType>())
        pushToken <- map["pushToken"]
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return DeviceInfo(device: device, pushToken: pushToken)
    }
    
    // MARK: NSCoding Protocol
    
    required public init(coder aDecoder: NSCoder) {
        if let device = aDecoder.decodeObject(forKey: "device") as? String {
            self.device = DeviceType(rawValue: device)
        }
        self.pushToken = aDecoder.decodeObject(forKey: "pushToken") as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(device?.rawValue, forKey: "device")
        aCoder.encode(pushToken, forKey: "pushToken")
    }
}
