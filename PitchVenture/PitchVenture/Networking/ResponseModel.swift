//
//  ResponseModel.swift
//  chef
//
//  Created by Nithaparan Francis on 2021-12-06.
//

import UIKit
import Foundation

class ResponseModel<T: Codable>: Codable {
    var statusCode: Int?
    var message: String?
    var data: T?

}
