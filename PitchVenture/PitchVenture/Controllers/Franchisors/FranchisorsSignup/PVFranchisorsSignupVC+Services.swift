//
//  PVFranchisorsSignupVC+Services.swift
//  PitchVenture
//
//  Created by Daksh Upadhyay on 2022-02-22.
//  Copyright © 2022 PitchVenture. All rights reserved.
//

import SwiftyJSON
import ObjectMapper

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
                            PVUserManager.sharedManager().activeUser = account
                            
                            if let acc = account.isComplete, acc {
                                //GO TO HOMEVC
                                self.showAlertWithTitleAndMessage(title: APP_NAME, msg: "Signup Successfull")
                                
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
        
    }
}
