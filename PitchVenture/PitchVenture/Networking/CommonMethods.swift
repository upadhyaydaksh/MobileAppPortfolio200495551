//
//  CommonMethods.swift
//  PitchVenture
//
//  Created by Harshit on 2022-02-18.
//  Copyright © 2022 PitchVenture. All rights reserved.
//

import Foundation
import UIKit
import Reachability
import SVProgressHUD
import Alamofire
import SwiftyJSON

public class CommonMethods: NSObject {
    
    public typealias NetworkSuccessHandler = (DataResponse<Any>) -> Void
    public typealias NetworkFailureHandler = (DataResponse<Any>, Error) -> Void
    
    static let sharedInstance: CommonMethods = {
        let instance = CommonMethods()
        // setup code
        instance.initialize()
        return instance
    }()
    let appDel = UIApplication.shared.delegate as? AppDelegate
    
    var isConnected: Bool = false
    var isLoggedIn: Bool  = false
    
    var reachability = Reachability()
    
    var userModel   :User? = nil
    var usrState    :Int = 0
    var deviceToken : String = "0"
    
    func initialize () {
        setUpSVProgressHUD()
    }
    
    func setUpSVProgressHUD () {
        //Progress hud settings
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.custom)
        SVProgressHUD.setForegroundColor(UIColor.black)
        SVProgressHUD.setBackgroundColor(UIColor.clear)
        SVProgressHUD.setRingThickness(5.0)
    }
    
    // MARK: - Date Conversion functions
    
    func utcStringToDate(_ dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        dateFormatter.timeZone = TimeZone.init(abbreviation: "UTC")
        let date = dateFormatter.date(from: dateString)
        return date!
    }
    
    func utcStringToDateYMD(_ dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone.init(abbreviation: "UTC")
        let date = dateFormatter.date(from: dateString)
        return date!
    }
    
    func utcDateFromString(string: String, usingDateFormat dateFormat: String) -> Date? {
        var formatter: DateFormatter? = nil
        if formatter == nil {
            formatter = DateFormatter()
            formatter!.locale = NSLocale(localeIdentifier: "en-US") as Locale?
        }
        formatter!.dateFormat = dateFormat
        formatter?.timeZone = TimeZone.init(abbreviation: "UTC")
        let date: Date = formatter!.date(from: string) ?? Date()
        return date
    }
    
    func nsDateFromString(string: String, usingDateFormat dateFormat: String) -> Date {
        var formatter: DateFormatter? = nil
        if formatter == nil {
            formatter = DateFormatter()
        }
        formatter!.dateFormat = dateFormat
        let date: Date = formatter!.date(from: string)!
        return date
    }
    
    func nsStringFromDate(date: Date, andToFormatString formatString: String) -> String {
        var formatter: DateFormatter? = nil
        if formatter == nil {
            formatter = DateFormatter()
        }
        formatter!.dateFormat = formatString
        let dateString: String = formatter!.string(from: date)
        return dateString
    }
    
    func nsUTCStringFromDate(date: Date, andToFormatString formatString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")! as TimeZone
        dateFormatter.dateFormat = formatString
        let dateString: String = dateFormatter.string(from: date)
        return dateString
    }
    
    func combineDateAndTime(date: Date, time: Date) -> Date {
        let calendar = NSCalendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        let timeComponents = calendar.dateComponents([.hour, .minute, .second], from: time)
        var components = DateComponents()
        components.year = dateComponents.year
        components.month = dateComponents.month
        components.day = dateComponents.day
        components.hour = timeComponents.hour
        components.minute = timeComponents.minute
        components.second = timeComponents.second
        
        return calendar.date(from: components)!
    }
    
    // MARK: - Progress HUD
    func showHud() {
        SVProgressHUD.show()
    }
    
    func showHudWithStatus(title:String) {
        SVProgressHUD.show(withStatus: title)
    }
    
    func hideHud() {
        SVProgressHUD.dismiss()
    }
    
    func JSONStringify(value: AnyObject,prettyPrinted:Bool = false) -> String{
        let options = prettyPrinted ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions(rawValue: 0)
        if JSONSerialization.isValidJSONObject(value) {
            do {
                let data = try JSONSerialization.data(withJSONObject: value, options: options)
                if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    return string as String
                }
            } catch {
                // print("error")
                //Access error here
            }
        }
        return ""
    }
}

let STR_LOADING                     = "Loading..."
let INVALID_RESPONSE                = "Invalid response from server."
let APP_NAME                        = "PitchVenture"
let SUCCESS                         = "success"
let STATUS_CODE                     = "statusCode"
let MESSAGE                         = "message"
