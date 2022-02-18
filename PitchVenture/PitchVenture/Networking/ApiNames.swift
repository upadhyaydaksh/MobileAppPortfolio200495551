//
//  ApiNames.swift
//  PitchVenture
//
//  Created by Akshay on 2022-02-18.
//  Copyright © 2022 PitchVenture. All rights reserved.
//

import Foundation
import UIKit

let MAIN_URL = "http://ec2-13-59-174-252.us-east-2.compute.amazonaws.com:3000/api/"

// WebService Name
let CREATE_ACCOUNT          = MAIN_URL + "account/createAccount"
let STORE_OWNER_SIGNUP      = MAIN_URL + "account/storeOwenerSignup"
let GET_ALL_FRANCHISES      = MAIN_URL + "account/getAllFranchises"
let GET_ALL_STORE_OWNERS    = MAIN_URL + "account/getAllStoreOwners"
