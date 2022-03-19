//
//  PVLoginVC+Services.swift
//  PitchVenture
//
//  Created by Harshit on 2022-02-22.
//  Copyright © 2022 PitchVenture. All rights reserved.
//

import UIKit
import SwiftyJSON
import ObjectMapper
import FirebaseAnalytics

extension PVLoginVC {
    
    //MARK: - API method call
    func callCreateUser(tokenID: String?) {
        CommonMethods.sharedInstance.showHud()
        var parameters = [String : Any]()
        parameters = [
            "tokenId" : tokenID ?? ""
        ]
        RequestManager.sharedInstance.callRespectiveWebservices(isSucces: { (response) in
            if let value = response.result.value {
                let json = JSON(value)
                if (json[STATUS_CODE].intValue == 2000) {
                    
                    
                    //IF REGISTRATION IS DONE
                    if let result = json["data"].dictionaryObject {
                        if let account: Account = Mapper<Account>().map(JSON: result) {
                            self.account = account
                            
                            if let acc = account.isComplete, acc {
                                //GO TO HOMEVC
                                
                                PVUserManager.sharedManager().activeUser = account
                                PVUserManager.sharedManager().saveActiveUser()
                                
                                let param = [AnalyticsParameterScreenName: "login_vc", "user_name" : self.account.name!, "user_id" : "\(self.account.id ?? "")"]
                                print("Analytics Login Param : \(param)")
                                Analytics.logEvent(AnalyticsEventLogin, parameters: param)
                                
                                let objPVStoreOwnerHomeVC = PVStoreOwnerHomeVC.instantiate()
                                self.push(vc: objPVStoreOwnerHomeVC)
                            } else {
                                //GO TO PHONE VERIFY VC FOR SIGNUP
                                let objPVPhoneVerifyVC = PVPhoneVerifyVC.instantiate()
                                objPVPhoneVerifyVC.account = self.account
                                self.push(vc: objPVPhoneVerifyVC)
                            }
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
        }, params: parameters, urlApi: CREATE_ACCOUNT)
    }
    
    //MARK: - API method call
    func callCreateUserWithAppleSignIn(token: String?,email: String?,appleUserId: String?,givenName: String?,familyName: String?) {
        CommonMethods.sharedInstance.showHud()
        var parameters = [String : Any]()
        parameters = [
            "token" : token ?? "",
            "email" : email ?? "",
            "appleUserId" : appleUserId ?? "",
            "givenName" : givenName ?? "",
            "familyName" : familyName ?? ""
        ]
        RequestManager.sharedInstance.callRespectiveWebservices(isSucces: { (response) in
            if let value = response.result.value {
                let json = JSON(value)
                if (json[STATUS_CODE].intValue == 2000) {
                    
                    //IF REGISTRATION IS DONE
                    if let result = json["data"].dictionaryObject {
                        if let account: Account = Mapper<Account>().map(JSON: result) {
                            self.account = account

                            if let acc = account.isComplete, acc {
                                //GO TO HOMEVC
                                PVUserManager.sharedManager().activeUser = account
                                PVUserManager.sharedManager().saveActiveUser()
                                
                                let objPVStoreOwnerHomeVC = PVStoreOwnerHomeVC.instantiate()
                                self.push(vc: objPVStoreOwnerHomeVC)
                            } else {
                                //GO TO PHONE VERIFY VC FOR SIGNUP
                                let objPVPhoneVerifyVC = PVPhoneVerifyVC.instantiate()
                                objPVPhoneVerifyVC.account = self.account
                                self.push(vc: objPVPhoneVerifyVC)
                            }
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
        }, params: parameters, urlApi: CREATE_ACCOUNT_APPLE)
    }
}
