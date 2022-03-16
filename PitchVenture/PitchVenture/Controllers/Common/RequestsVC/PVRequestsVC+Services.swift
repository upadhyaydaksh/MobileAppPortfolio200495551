//
//  PVRequestsVC+Services.swift
//  PitchVenture
//
//  Created by Daksh Upadhyay on 2022-02-22.
//  Copyright © 2022 PitchVenture. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper

extension PVRequestsVC {
    
    func getAllFranchisorsRequests(){
        
        var authHeader:HTTPHeaders = [:]
         
        let account = PVUserManager.sharedManager().activeUser
        if let accountToken = account?.token {
            authHeader = ["Authorization": "Bearer " + accountToken.trimmedString(),
                          "Content-Type" : "application/json"]
        }
        _ = Alamofire.request(GET_ALL_FRANCHISORS_REQUESTS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: authHeader).validate().responseJSON { (response) in
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
    
    func getAllStoreOwnersRequests() {
        var authHeader:HTTPHeaders = [:]
         
        let account = PVUserManager.sharedManager().activeUser
        if let accountToken = account?.token {
            authHeader = ["Authorization": "Bearer " + accountToken.trimmedString(),
                          "Content-Type" : "application/json"]
        }
        _ = Alamofire.request(GET_ALL_STORE_OWNERS_REQUESTS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: authHeader).validate().responseJSON { (response) in
            print("--------- Request URL - %@", response.request?.url ?? "")
            CommonMethods.sharedInstance.hideHud()

            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("JSON: \(json)")
                    if (json["statusCode"].numberValue == 2000) {
                        print("Success")
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
    
    func acceptRequest(account: Account?) {
        //
        CommonMethods.sharedInstance.showHud()
        
        if let userID = account?.id, userID != nil {
            let urlName = "\(CALL_ACCEPT_REQUEST)\(userID)"
            print(urlName)
            
            RequestManager.sharedInstance.callRespectiveWebservices(isSucces: { (response) in
                if let value = response.result.value {
                    let json = JSON(value)
                    if (json[STATUS_CODE].intValue == 2000) {
                        
                        self.showAlertWithMessage(msg: "Request Accepted successfully.")
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
    
    func rejectRequest(account: Account?) {
        //
        CommonMethods.sharedInstance.showHud()
        
        if let userID = account?.id, userID != nil {
            let urlName = "\(CALL_REJECT_REQUEST)\(userID)"
            print(urlName)
            
            RequestManager.sharedInstance.callRespectiveWebservices(isSucces: { (response) in
                if let value = response.result.value {
                    let json = JSON(value)
                    if (json[STATUS_CODE].intValue == 2000) {
                        
                        self.showAlertWithMessage(msg: "Request Rejected successfully.")
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
}
