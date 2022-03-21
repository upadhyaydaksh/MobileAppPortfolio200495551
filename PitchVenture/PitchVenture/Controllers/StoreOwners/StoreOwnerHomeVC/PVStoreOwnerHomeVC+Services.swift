//
//  PVStoreOwnerHomeVC+Services.swift
//  PitchVenture
//
//  Created by Harshit on 2022-02-18.
//  Copyright © 2022 PitchVenture. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper
import FirebaseAnalytics

extension PVStoreOwnerHomeVC {
    
    func getAllFranchises() {
        CommonMethods.sharedInstance.showHudWithStatus(title: STR_LOADING)
        
        self.arrFranchises.removeAll()
        
        _ = Alamofire.request(GET_ALL_FRANCHISES, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate().responseJSON { (response) in
            print("--------- Request URL - %@", response.request?.url ?? "")
            CommonMethods.sharedInstance.hideHud()

            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("JSON: \(json)")
                    if (json["statusCode"].numberValue == 2000) {
                        if let resultArray = json["data"].array {
                            for i in 0 ..< resultArray.count {
                                
                                if let franchise: Account = Mapper<Account>().map(JSON: resultArray[i].rawValue as! [String : Any]) {
                                    self.arrFranchises.append(franchise)
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
                    self.tableView.reloadData()
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
    
    func getAllStoreOwners() {
        CommonMethods.sharedInstance.showHudWithStatus(title: STR_LOADING)
        
        self.arrFranchises.removeAll()
        
        _ = Alamofire.request(GET_ALL_STORE_OWNERS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate().responseJSON { (response) in
            print("--------- Request URL - %@", response.request?.url ?? "")
            CommonMethods.sharedInstance.hideHud()

            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("JSON: \(json)")
                    if (json["\(STATUS_CODE)"].numberValue == 2000) {
                        if let resultArray = json["data"].array {
                            for i in 0 ..< resultArray.count {
                                
                                if let franchise: Account = Mapper<Account>().map(JSON: resultArray[i].rawValue as! [String : Any]) {
                                    self.arrFranchises.append(franchise)
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
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
                if let data = response.data {
                    print("Response data: \(NSString(data: data, encoding: String.Encoding.utf8.rawValue)!)")
                }
            }
        }

    }
    
    func callSendRequest(user: Account?) {
        CommonMethods.sharedInstance.showHud()
        
        if let userID = user?.id, userID != nil {
            let urlName = "\(CALL_SEND_REQUEST)\(userID)"
            print(urlName)
            
            RequestManager.sharedInstance.callRespectiveWebservices(isSucces: { (response) in
                if let value = response.result.value {
                    let json = JSON(value)
                    if (json[STATUS_CODE].intValue == 2000) {
                        
                        let param = [AnalyticsParameterScreenName: "franchisor_request_sent", "user_name" : self.account.name!, "user_id" : "\(self.account.id ?? "")", "franchisor_request_sent": "true"]
                        print("Analytics Login Param : \(param)")
                        Analytics.logEvent("FranchiseRequestSent", parameters: param)
                        
                        self.showAlertWithMessage(msg: "Request sent successfully.")
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
            }, params: [:], urlApi: urlName)
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
                            
                            self.account = PVUserManager.sharedManager().activeUser
                            
                            if self.account.isFranchise! {
                                self.getAllStoreOwners()
                            } else {
                                self.getAllFranchises()
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
                }
            case .failure(let error):
                print(error)
                if let data = response.data {
                    print("Response data: \(NSString(data: data, encoding: String.Encoding.utf8.rawValue)!)")
                }
            }
        }
    }
}
