//
//  PVFranchisorsSignupVC+Services.swift
//  PitchVenture
//
//  Created by Daksh Upadhyay on 2022-02-22.
//  Copyright © 2022 PitchVenture. All rights reserved.
//

import SwiftyJSON
import Alamofire
import SwiftyJSON
import ObjectMapper
import FirebaseAnalytics

extension PVFranchisorsSignupVC {
    
    //MARK: - API method call
    func callFranchiseSignup(parameters: [String : Any]) {
        CommonMethods.sharedInstance.showHud()
        
        RequestManager.sharedInstance.callRespectiveWebservices(isSucces: { (response) in
            if let value = response.result.value {
                let json = JSON(value)
                if (json[STATUS_CODE].intValue == 2000) {
                    
                    //SIGNUP SUCCESSFULL
                    if let result = json["data"].dictionaryObject {
                        if let account: Account = Mapper<Account>().map(JSON: result) {
                            self.account = account
                            
                            if let acc = account.isComplete, acc {
                                //GO TO HOMEVC
                                
                                PVUserManager.sharedManager().activeUser = account
                                PVUserManager.sharedManager().saveActiveUser()
                                
                                let param = [AnalyticsParameterScreenName: "franchisor_signup_vc", "user_name" : self.account.name!, "user_id" : "\(self.account.id ?? "")", "franchisor_signup": "true"]
                                print("Analytics Login Param : \(param)")
                                Analytics.logEvent("FranchisorSignup", parameters: param)
                                
                                let objPVStoreOwnerHomeVC = PVStoreOwnerHomeVC.instantiate()
                                self.push(vc: objPVStoreOwnerHomeVC)
                                
                                self.showAlertWithTitleAndMessage(title: APP_NAME, msg: "Signup Successfull")
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
        }, params: parameters, urlApi: FRANCHISE_SIGNUP)
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
                                
                                for i in 0 ..< self.arrAppData.count {
                                    self.itemList.append(self.arrAppData[i].name ?? "")
                                }
                                
                                self.txtFranchiseCategory.itemList = self.itemList
                            }
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
//                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
                if let data = response.data {
                    print("Response data: \(NSString(data: data, encoding: String.Encoding.utf8.rawValue)!)")
                    //CommonMethods.sharedInstance.showAlertWithMessage(message: error.localizedDescription, withController: self)
                }
            }
        }
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
