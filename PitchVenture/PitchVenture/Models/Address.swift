//
//  Address.swift
//  Zirco
//
//  Created by Hemant Sharma on 29/06/18.
//  Copyright © 2019 PHYX. All rights reserved.
//

import UIKit
import ObjectMapper
import CoreLocation

class Address: NSObject, Mappable, NSCoding, NSCopying {
    
    // MARK: Properties
    public var id: NSNumber?
    public var fullAddress: String?
    public var addressLine1: String?
    public var addressLine2: String?
    public var landmark: String?
    public var city: String?
    public var zipCode: String?
    public var country: String?
    public var countryShort: String?
    public var state: String?
    public var stateShort: String?
    public var location: CLLocation?
    
    
    // MARK: ObjectMapper Initalizers
    /**
     Map a JSON object to this class using ObjectMapper
     - parameter map: A mapping from ObjectMapper
     */
    required public init?(map: Map){
        
    }
    
    override init() {
        self.id = nil
        self.fullAddress = nil
        self.addressLine1 = nil
        self.addressLine2 = nil
        self.city = nil
        self.zipCode = nil
        self.country = nil
        self.countryShort = nil
        self.state = nil
        self.stateShort = nil
        self.location = nil
    }
    
    init(id: NSNumber?, fullAddress: String?, addressLine1: String?, addressLine2: String?, city: String?, zipCode: String?, country: String?, countryShort: String?, state: String?, stateShort: String?, location: CLLocation?) {
        self.id = id
        self.fullAddress = fullAddress
        self.addressLine1 = addressLine1
        self.addressLine2 = addressLine2
        self.city = city
        self.zipCode = zipCode
        self.country = country
        self.countryShort = countryShort
        self.state = state
        self.stateShort = stateShort
        self.location = location
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Address(id: id, fullAddress: fullAddress, addressLine1: addressLine1, addressLine2: addressLine2, city: city, zipCode: zipCode, country: country, countryShort: countryShort, state: state, stateShort: stateShort, location: location)
    }
    
    /**
     Map a JSON object to this class using ObjectMapper
     - parameter map: A mapping from ObjectMapper
     */
    public func mapping(map: Map) {
        id <- map["id"]
        fullAddress <- map["fullAddress"]
        addressLine1 <- map["addressLine1"]
        addressLine2 <- map["addressLine2"]
        landmark <- map["landmark"]
        city <- map["city"]
        zipCode <- map["zipCode"]
        country <- map["country"]
        countryShort <- map["countryShort"]
        state <- map["state"]
        stateShort <- map["stateShort"]
        
        var latitude: String?
        var longitude: String?
        
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        
        if latitude != nil && longitude != nil {
            if Double(latitude!) != nil && Double(longitude!) != nil {
                location = CLLocation(latitude: Double(latitude!)!, longitude: Double(longitude!)!)
            }
        }
    
        var locationTemp: [String: Any]?
        locationTemp <- map["location"]
        if let coordinates = locationTemp?["coordinates"] as? [NSNumber] {
            if let lat = coordinates.last?.doubleValue {
                if let long = coordinates.first?.doubleValue {
                    location = CLLocation(latitude: lat, longitude: long)
                }
            }
        }
        
    }
    
    // MARK: NSCoding Protocol
    
    required public init(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: "id") as? NSNumber
        self.fullAddress = aDecoder.decodeObject(forKey: "fullAddress") as? String
        self.addressLine1 = aDecoder.decodeObject(forKey: "addressLine1") as? String
        self.addressLine2 = aDecoder.decodeObject(forKey: "addressLine2") as? String
        self.landmark = aDecoder.decodeObject(forKey: "landmark") as? String
        self.city = aDecoder.decodeObject(forKey: "city") as? String
        self.zipCode = aDecoder.decodeObject(forKey: "zipCode") as? String
        self.country = aDecoder.decodeObject(forKey: "country") as? String
        self.countryShort = aDecoder.decodeObject(forKey: "countryShort") as? String
        self.state = aDecoder.decodeObject(forKey: "state") as? String
        self.stateShort = aDecoder.decodeObject(forKey: "stateShort") as? String
        self.location = aDecoder.decodeObject(forKey: "location") as? CLLocation
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(fullAddress, forKey: "fullAddress")
        aCoder.encode(addressLine1, forKey: "addressLine1")
        aCoder.encode(addressLine2, forKey: "addressLine2")
        aCoder.encode(landmark, forKey: "landmark")
        aCoder.encode(city, forKey: "city")
        aCoder.encode(zipCode, forKey: "zipCode")
        aCoder.encode(country, forKey: "country")
        aCoder.encode(countryShort, forKey: "countryShort")
        aCoder.encode(state, forKey: "state")
        aCoder.encode(stateShort, forKey: "stateShort")
        aCoder.encode(location, forKey: "location")
    }
    
    // MARK: - Other Methods
    
    func getFullAddress() -> String {
        var newString = ""
        if !addressLine1.isNullOrEmpty() {
            newString.append(addressLine1!)
        }
        if !addressLine2.isNullOrEmpty() {
            if newString.count != 0 {
                newString.append(", ")
            }
            newString.append(addressLine2!)
        }
        if !city.isNullOrEmpty() {
            if newString.count != 0 {
                newString.append(", ")
            }
            newString.append(city!)
        }
        if !stateShort.isNullOrEmpty() {
            if newString.count != 0 {
                newString.append(", ")
            }
            newString.append(stateShort!)
        }
        if !country.isNullOrEmpty() {
            if newString.count != 0 {
                newString.append(", ")
            }
            newString.append(country!)
        }
        if !zipCode.isNullOrEmpty() {
            if newString.count != 0 {
                newString.append(" - ")
            }
            newString.append(zipCode!)
        }
        return newString
        //return "\(addressLine1 ?? ""), \(addressLine2 ?? "")\n\(city ?? ""), \(stateShort ?? "") \(zipCode ?? "")".trimmedString()
    }
    
    func getAddressOfCircle() -> String {
        var newString = ""
        if !city.isNullOrEmpty() {
            if newString.count != 0 {
                newString.append(", ")
            }
            newString.append(city!)
        }
        if !stateShort.isNullOrEmpty() {
            if newString.count != 0 {
                newString.append(", ")
            }
            newString.append(stateShort!)
        }
        return newString
        //return "\(addressLine1 ?? ""), \(addressLine2 ?? "")\n\(city ?? ""), \(stateShort ?? "") \(zipCode ?? "")".trimmedString()
    }
    
    func getFullAddressSingleLine() -> String {
        var newString = ""
        if !addressLine1.isNullOrEmpty() {
            newString.append(addressLine1!)
        }
        if !addressLine2.isNullOrEmpty() {
            newString.append(", ")
            newString.append(addressLine2!)
        }
        if !city.isNullOrEmpty() {
            newString.append(", ")
            newString.append(city!)
        }
        if !stateShort.isNullOrEmpty() {
            newString.append(", ")
            newString.append(stateShort!)
        }
        if !zipCode.isNullOrEmpty() {
            newString.append(" ")
            newString.append(zipCode!)
        }
        return newString
    }
    
    func isEmpty() -> Bool {
        if addressLine1.isNullOrEmpty() || zipCode.isNullOrEmpty() || city.isNullOrEmpty() || state.isNullOrEmpty() || country.isNullOrEmpty() || location == nil {
            return true
        }
        return false
    }
    
    func isAddressComplete() -> (Bool, String) {
        if addressLine1.isNullOrEmpty() {
            return (false, "Address Line 1 is empty")
        } else if zipCode.isNullOrEmpty() {
            return (false, "Zip Code is empty")
        } else if city.isNullOrEmpty() {
            return (false, "City is empty")
        } else if state.isNullOrEmpty() ||  stateShort.isNullOrEmpty() {
            return (false, "State is empty")
        } else if country.isNullOrEmpty() ||  countryShort.isNullOrEmpty() {
            return (false, "Country is empty")
        } else if location == nil {
            return (false, "Location is not available for this place")
        }
        return (true, "Success")
    }
}

