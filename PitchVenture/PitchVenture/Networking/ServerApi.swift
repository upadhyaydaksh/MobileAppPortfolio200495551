//
//  ServerApi.swift
//  chef
//
//  Created by Nithaparan Francis on 2021-12-06.
//

//import Foundation
////import Moya
//
//// 1:
//enum MyServerAPI {
//
//    case googleSignIn(data: [String: Any])
//
//    case storeOwenerSignup(data: [String: Any])
//
//    case getAllFranchises(data: [String: Any])
//
//    case getAllStoreOwners(data: [String: Any])
//}
//
//// 2:
//extension MyServerAPI: TargetType {
//
//    
//
//
//    // 3:
//    var baseURL: URL { return URL(string: "http://ec2-13-59-174-252.us-east-2.compute.amazonaws.com:3000/api")! }
//
//    // 4:
//    var path: String {
//        switch self {
//        case .googleSignIn:
//            return "account/createAccount"
//
//        case .storeOwenerSignup:
//            return "account/storeOwenerSignup"
//
//        case .getAllFranchises:
//            return "account/getAllFranchises"
//
//        case .getAllStoreOwners:
//            return "account/getAllStoreOwners"
//        }
//    }
//
//    // 5:
//    var method: Moya.Method {
//        switch self {
//        case .googleSignIn,.storeOwenerSignup:
//            return .post
//        default:
//            return .get
//        }
//    }
//
//    // 6:
//    var parameters: [String: Any]? {
//        return nil
//    }
//
//    // 7:
//    var parameterEncoding: ParameterEncoding {
//        return JSONEncoding.default
//    }
//
//    // 8:
//    var sampleData: Data {
//        return Data()
//    }
//
//    // 9:
//    var task: Task {
//        switch self {
//        case .googleSignIn(data: let data):
//            return .requestParameters(parameters: data, encoding: JSONEncoding.default)
//
//        case .storeOwenerSignup(data: let data):
//            return .requestParameters(parameters: data, encoding: JSONEncoding.default)
//
//        case .getAllFranchises(data: let data):
//            return .requestParameters(parameters: data, encoding: JSONEncoding.default)
//
//        case .getAllStoreOwners(data: let data):
//            return .requestParameters(parameters: data, encoding: JSONEncoding.default)
//
//        default:
//            return .requestPlain
//        }
//    }
//
//    var headers: [String : String]?{
//        var header: [String: String]? = [:]
//        header!["Content-Type"] = "application/json"
////        if let accessToken = Helper.instance.getAuthenticationToken() {
////            header!["Authorization"] = "Bearer \(accessToken)"
////        }
//        return header
//    }
//}

