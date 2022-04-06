//
//  PVSponsoredVC+Services.swift
//  PitchVenture
//
//  Created by Daksh Upadhyay on 2022-04-05.
//  Copyright © 2022 PitchVenture. All rights reserved.
//

import UIKit
import SwiftyJSON
import ObjectMapper
import FirebaseAnalytics

extension PVSponsoredVC {
    
    func storeOwenerUpdate(parameters: [String : Any]) {
        CommonMethods.sharedInstance.showHud()
        
        RequestManager.sharedInstance.callRespectivePutWebservices(isSucces: { (response) in
            if let value = response.result.value {
                let json = JSON(value)
                if (json[STATUS_CODE].intValue == 2000) {
                    
                    //SIGNUP SUCCESSFULL
                    if let result = json["data"].dictionaryObject {
                        if let account: Account = Mapper<Account>().map(JSON: result) {
                            self.account = account
                            PVUserManager.sharedManager().activeUser = account
                            PVUserManager.sharedManager().saveActiveUser()
                            
                            let param = [AnalyticsParameterScreenName: "input_location_vc", "user_name" : self.account.name!, "user_id" : "\(self.account.id ?? "")", "store_owner_sponsored": "true"]
                            print("Analytics Login Param : \(param)")
                            Analytics.logEvent("StoreOwnerSponsor", parameters: param)
                            
                            self.showAlertWithTitleAndMessage(title: APP_NAME, msg: "Profile sponsored successfully for 14 days.")
                        }
                    } else {
                        self.showAlertWithTitleAndMessage(title: APP_NAME, msg: INVALID_RESPONSE)
                    }
                } else {
                    let message = json[MESSAGE].stringValue
                    self.showAlertWithMessage(msg: message)
                }
            }
        }, isFailure: { (isCancelled, error) in
            if error?._code != NSURLErrorCancelled {
                if (error?._code == -1001 || error?._code == -1005) {
                    
                } else {
                    self.showAlertWithMessage(msg: (error?.localizedDescription)!)
                }
            }
        }, params: parameters, urlApi: STORE_OWNER_UPDATE)
    }
    
    func franchisorUpdate(parameters: [String : Any]) {
        CommonMethods.sharedInstance.showHud()
        
        RequestManager.sharedInstance.callRespectivePutWebservices(isSucces: { (response) in
            if let value = response.result.value {
                let json = JSON(value)
                if (json[STATUS_CODE].intValue == 2000) {
                    
                    //SIGNUP SUCCESSFULL
                    if let result = json["data"].dictionaryObject {
                        if let account: Account = Mapper<Account>().map(JSON: result) {
                            self.account = account
                            PVUserManager.sharedManager().activeUser = account
                            PVUserManager.sharedManager().saveActiveUser()
                            
                            let param = [AnalyticsParameterScreenName: "franchisor_signup_vc", "user_name" : self.account.name!, "user_id" : "\(self.account.id ?? "")", "franchisor_profile_updated": "true"]
                            print("Analytics Login Param : \(param)")
                            Analytics.logEvent("FranchiseDetailsUpdated", parameters: param)
                            
                            
                            self.showAlertWithTitleAndMessage(title: APP_NAME, msg: "Profile updated successfully.")
                        }
                    } else {
                        self.showAlertWithTitleAndMessage(title: APP_NAME, msg: INVALID_RESPONSE)
                    }
                } else {
                    let message = json[MESSAGE].stringValue
                    self.showAlertWithMessage(msg: message)
                }
            }
        }, isFailure: { (isCancelled, error) in
            if error?._code != NSURLErrorCancelled {
                if (error?._code == -1001 || error?._code == -1005) {
                    
                } else {
                    self.showAlertWithMessage(msg: (error?.localizedDescription)!)
                }
            }
        }, params: parameters, urlApi: FRANCHISE_UPDATE)
    }
}
