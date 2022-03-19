//
//  PVStoreOwnerProfileVC+Services.swift
//  PitchVenture
//
//  Created by Daksh on 2022-02-22.
//  Copyright © 2022 PitchVenture. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import ObjectMapper
import FirebaseAnalytics

extension PVStoreOwnerProfileVC{

    func getProfile() {
        
        _ = Alamofire.request(GET_PROFILE + "\(PVUserManager.sharedManager().activeUser?.id! ?? "")", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate().responseJSON { (response) in
            print("--------- Request URL - %@", response.request?.url ?? "")
            CommonMethods.sharedInstance.hideHud()

            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("JSON: \(json)")
                    if (json["statusCode"].numberValue == 2000) {
                        if let result = json["data"].dictionaryObject {
                            if let account: Account = Mapper<Account>().map(JSON: result) {
                                self.account = account
                            }
                            self.tableView.reloadData()
                        } else {
                            self.showAlertWithTitleAndMessage(title: APP_NAME, msg: INVALID_RESPONSE)
                        }
                    } else {
                        if let message = json["message"].string {
                            self.showAlertWithMessage(msg: message)
                        } else {
                            self.showAlertWithTitleAndMessage(title: APP_NAME, msg: INVALID_RESPONSE)
                        }
                    }
                }
            case .failure(let error):
                print(error)
                if let data = response.data {
                    print("Response data: \(NSString(data: data, encoding: String.Encoding.utf8.rawValue)!)")
                    self.showAlertWithMessage(msg: error.localizedDescription)
                }
            }
        }

    }
    
    func getAppData(){
        _ = Alamofire.request(GET_APP_DATA, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate().responseJSON { (response) in
            print("--------- Request URL - %@", response.request?.url ?? "")
            CommonMethods.sharedInstance.hideHud()

            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("JSON: \(json)")
                    if (json["statusCode"].numberValue == 2000) {
                        if let dataDic = json["data"].dictionary {
                            
                            if let franchiseCategory = dataDic["franchiseCategories"]?.array {
                                for i in 0 ..< franchiseCategory.count {

                                    if let appData: AppData = Mapper<AppData>().map(JSON: franchiseCategory[i].rawValue as! [String : Any]) {
                                        self.arrAppData.append(appData)
                                    }
                                }
                            }
                            
                            self.tableView.reloadData()
                        } else {
                            self.showAlertWithTitleAndMessage(title: APP_NAME, msg: INVALID_RESPONSE)
                        }
                    } else {
                        if let message = json["message"].string {
                            self.showAlertWithMessage(msg: message)
                        } else {
                            self.showAlertWithTitleAndMessage(title: APP_NAME, msg: INVALID_RESPONSE)
                        }
                    }
                }
            case .failure(let error):
                print(error)
                if let data = response.data {
                    print("Response data: \(NSString(data: data, encoding: String.Encoding.utf8.rawValue)!)")
                }
            }
        }
    }
    
    //MARK: - API method call
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
                            
                            let param = [AnalyticsParameterScreenName: "store_owner_profile_vc", "user_name" : self.account.name!, "user_id" : "\(self.account.id ?? "")"]
                            print("Analytics Param : \(param)")
                            Analytics.logEvent("StoreOwnerProfileUpdate", parameters: param)
                            
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
                            
                            let param = [AnalyticsParameterScreenName: "store_owner_profile_vc", "user_name" : self.account.name!, "user_id" : "\(self.account.id ?? "")"]
                            print("Analytics Param : \(param)")
                            Analytics.logEvent("FranchisorProfileUpdate", parameters: param)
                            
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
