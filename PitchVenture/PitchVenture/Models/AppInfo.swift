//
//  AppInfo.swift
//  BodyFixers
//
//  Created by Hemant Sharma on 12/07/17.
//  Copyright © 2019 PHYX. All rights reserved.
//

import UIKit
import ObjectMapper

class AppInfo: NSObject, Mappable, NSCopying, NSCoding {
    
    // MARK: Properties
    public var appID: String?
    public var appVersion: String?
    
    // MARK: ObjectMapper Initalizers
    /**
     Map a JSON object to this class using ObjectMapper
     - parameter map: A mapping from ObjectMapper
     */
    required public init?(map: Map){
        
    }
    
    init(appID: String?, appVersion: String?) {
        self.appID = appID
        self.appVersion = appVersion
    }
    
    /**
     Map a JSON object to this class using ObjectMapper
     - parameter map: A mapping from ObjectMapper
     */
    public func mapping(map: Map) {
        appID <- map["appID"]
        appVersion <- map["appVersion"]
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return AppInfo(appID: appID, appVersion: appVersion)
    }
    
    // MARK: NSCoding Protocol
    
    required public init(coder aDecoder: NSCoder) {
        self.appID = aDecoder.decodeObject(forKey: "appID") as? String
        self.appVersion = aDecoder.decodeObject(forKey: "appVersion") as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(appID, forKey: "appID")
        aCoder.encode(appVersion, forKey: "appVersion")
    }
}
