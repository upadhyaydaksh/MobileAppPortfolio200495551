//
//  Country.swift
//  GoKone
//
//  Created by Apple on 01/08/20.
//  Copyright © 2020 ZW. All rights reserved.
//

import UIKit
import ObjectMapper

private let kCountriesFileName = "countries"

class Country: NSObject, Mappable, NSCoding {
    
    // MARK: Properties
    public var id: NSNumber?
    public var sort_name: String = ""
    public var name: String = ""
    public var country_code: String = ""
    
    public var isSelected: Bool = false
    
    init(id: NSNumber?, sort_name: String, name: String, country_code: String, isSelected: Bool) {
        self.id = id
        self.sort_name = sort_name
        self.name = name
        self.country_code = country_code
        self.isSelected = isSelected
    }
    
    override init() {
        self.id = nil
        self.sort_name = ""
        self.name = ""
        self.country_code = ""
        self.isSelected = false
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
        sort_name <- map["sort_name"]
        name <- map["name"]
        country_code <- map["country_code"]
    }
    
    // MARK: NSCoding Protocol
    
    required public init(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: "id") as? NSNumber
        self.sort_name = aDecoder.decodeObject(forKey: "sort_name") as! String
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.country_code = aDecoder.decodeObject(forKey: "country_code") as! String
        self.isSelected = aDecoder.decodeBool(forKey: "isSelected")
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(sort_name, forKey: "sort_name")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(country_code, forKey: "country_code")
        aCoder.encode(isSelected, forKey: "isSelected")
    }
}

extension Country {
    
    static private var arrCountries: [Country] = []
    
    class private func parseJSON() {
        if let path = Bundle.main.path(forResource: kCountriesFileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let countries = jsonResult as? [[String: Any]] {
                    // do stuff
                    arrCountries.removeAll()
                    for dic in countries {
                        //"name":"Afghanistan","dial_code":"+93","code":"AF"
                        let country: Country = Country(id: nil, sort_name: (dic["code"] as! String), name: (dic["name"] as! String), country_code: (dic["dial_code"] as! String), isSelected: false)
                        arrCountries.append(country)
                    }
                }
            } catch {
                // handle error
                debugPrint("Error reading country.json file.")
            }
        }
    }
    
    class func countries() -> [Country] {
        Country.parseJSON()
        return arrCountries
    }
    
}
