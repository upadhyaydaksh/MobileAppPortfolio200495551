//
//  PVPhoneVerifyVC+Services.swift
//  PitchVenture
//
//  Created by Daksh Upadhyay on 2022-02-22.
//  Copyright © 2022 PitchVenture. All rights reserved.
//

import UIKit
import ObjectMapper
import SwiftyJSON

extension PVPhoneVerifyVC {
    
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
                                let objPVStoreOwnerHomeVC = PVStoreOwnerHomeVC.instantiate()
                                
                                if let isFranchise = account.isFranchise, isFranchise {
                                    objPVStoreOwnerHomeVC.userLoginType = .Franchisor
                                } else {
                                    objPVStoreOwnerHomeVC.userLoginType = .StoreOwner
                                }
                                self.push(vc: objPVStoreOwnerHomeVC)
                            } else {
                                //GO TO PHONE VERIFY VC FOR SIGNUP
                                let objPVPhoneVerifyVC = PVPhoneVerifyVC.instantiate()
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
}
