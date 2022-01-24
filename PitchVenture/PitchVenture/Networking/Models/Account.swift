//
//  Account.swift
//  PitchVenture
//
//  Created by Nithaparan Francis on 2022-01-24.
//  Copyright © 2022 PitchVenture. All rights reserved.
//

import Foundation

class Account: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case id = "_id"
        case email
        case picture
        case isComplete
        case isFranchise
        case createdAt
        case token
        case refreshToken
    }
    var picture: String
    var id: String
    var name: String
    var email: String
    var isComplete: Bool
    var isFranchise: Bool
    var createdAt: String
    var token: String?
    var refreshToken: String?
}
