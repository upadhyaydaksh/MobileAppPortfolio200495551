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
    
    func getAllParteneredStoreOwners(){
                        
        _ = Alamofire.request(GET_ALL_PARTNERED_STORE_OWNERS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate().responseJSON { (response) in
            print("--------- Request URL - %@", response.request?.url ?? "")
            CommonMethods.sharedInstance.hideHud()

            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("JSON: \(json)")
                    if (json["statusCode"].numberValue == 2000) {
//                        if let resultArray = json["data"].array {
//                            for i in 0 ..< resultArray.count {
//
//                                if let franchise: Account = Mapper<Account>().map(JSON: resultArray[i].rawValue as! [String : Any]) {
//                                    self.arrFranchises.append(franchise)
//                                }
//
//                            }
//                            self.tableView.reloadData()
//                        } else {
//                            self.showAlertWithTitleAndMessage(title: APP_NAME, msg: INVALID_RESPONSE)
//                        }
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
    
    func getAllFranchisorsRequests(){        
                        
        _ = Alamofire.request(GET_ALL_FRANCHISORS_REQUESTS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate().responseJSON { (response) in
            print("--------- Request URL - %@", response.request?.url ?? "")
            CommonMethods.sharedInstance.hideHud()

            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("JSON: \(json)")
                    if (json["statusCode"].numberValue == 2000) {
//                        if let resultArray = json["data"].array {
//                            for i in 0 ..< resultArray.count {
//
//                                if let franchise: Account = Mapper<Account>().map(JSON: resultArray[i].rawValue as! [String : Any]) {
//                                    self.arrFranchises.append(franchise)
//                                }
//
//                            }
//                            self.tableView.reloadData()
//                        } else {
//                            self.showAlertWithTitleAndMessage(title: APP_NAME, msg: INVALID_RESPONSE)
//                        }
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
    
    func getAllStoreOwnersRequests(){
                                
        _ = Alamofire.request(GET_ALL_STORE_OWNERS_REQUESTS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate().responseJSON { (response) in
            print("--------- Request URL - %@", response.request?.url ?? "")
            CommonMethods.sharedInstance.hideHud()

            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("JSON: \(json)")
                    if (json["statusCode"].numberValue == 2000) {
//                        if let resultArray = json["data"].array {
//                            for i in 0 ..< resultArray.count {
//
//                                if let franchise: Account = Mapper<Account>().map(JSON: resultArray[i].rawValue as! [String : Any]) {
//                                    self.arrFranchises.append(franchise)
//                                }
//
//                            }
//                            self.tableView.reloadData()
//                        } else {
//                            self.showAlertWithTitleAndMessage(title: APP_NAME, msg: INVALID_RESPONSE)
//                        }
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
    
    func sendRequest(){        
    }
    
    func acceptRequest(){
        
    }
    
    func rejectRequest(){
        
    }
}
