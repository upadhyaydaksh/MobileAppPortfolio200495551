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
}
