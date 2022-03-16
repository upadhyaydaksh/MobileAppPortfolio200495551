//
//  ApiNames.swift
//  PitchVenture
//
//  Created by Harshit on 2022-02-18.
//  Copyright © 2022 PitchVenture. All rights reserved.
//

import Foundation
import UIKit

let MAIN_URL = "http://ec2-13-59-174-252.us-east-2.compute.amazonaws.com:3000/api/"
let MAIN_URL_ACCOUNT = "http://ec2-13-59-174-252.us-east-2.compute.amazonaws.com:3000/api/account/"
let MAIN_URL_REQUEST = "http://ec2-13-59-174-252.us-east-2.compute.amazonaws.com:3000/api/request/"

//ACCOUNT
let CREATE_ACCOUNT                = MAIN_URL_ACCOUNT + "createAccount"
let CREATE_ACCOUNT_APPLE          = MAIN_URL_ACCOUNT + "appleSignIn"

let STORE_OWNER_SIGNUP            = MAIN_URL_ACCOUNT + "storeOwenerSignup"
let STORE_OWNER_UPDATE            = MAIN_URL_ACCOUNT + "storeOwenerUpdate"

let FRANCHISE_SIGNUP              = MAIN_URL_ACCOUNT + "franchiseSignup"
let FRANCHISE_UPDATE              = MAIN_URL_ACCOUNT + "franchiseUpdate"

let GET_ALL_FRANCHISES            = MAIN_URL_ACCOUNT + "getAllFranchises"
let GET_ALL_STORE_OWNERS          = MAIN_URL_ACCOUNT + "getAllStoreOwners"
let GET_PROFILE                   = MAIN_URL_ACCOUNT + "getProfile/"

let GET_APP_DATA                  = MAIN_URL_ACCOUNT + "appData"

//REQUESTS
let GET_ALL_PARTNERED_STORE_OWNERS = MAIN_URL_REQUEST + "getAllPartneredStoreOwners"
let GET_ALL_FRANCHISORS_REQUESTS   = MAIN_URL_REQUEST + "getAllRequests"
let GET_ALL_STORE_OWNERS_REQUESTS  = MAIN_URL_REQUEST + "getAllRequests"

let CALL_SEND_REQUEST                   = MAIN_URL_REQUEST + "sendRequest/"
let CALL_ACCEPT_REQUEST                 = MAIN_URL_REQUEST + "acceptRequest/"
let CALL_REJECT_REQUEST                 = MAIN_URL_REQUEST + "rejectRequest/"
