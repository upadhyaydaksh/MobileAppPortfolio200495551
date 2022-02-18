//
//  ResponseModel.swift
//  chef
//
//  Created by Nithaparan Francis on 2021-12-06.
//

class ResponseModel<T: Codable>: Codable {
    var statusCode: Int?
    var message: String?
    var data: T?

}
