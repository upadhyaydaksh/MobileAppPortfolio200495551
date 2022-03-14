//
//  AccountService.swift
//  chef
//
//  Created by Nithaparan Francis on 2021-12-06.
//

import Foundation

//class AccountService {
//    
//    func googleSignIn(data: [String: Any], onSuccess: @escaping (ResponseModel<Account>?) -> Void, onError: @escaping (LoginError) -> Void) {
//        
//        NetworkAdapter.request(target: .googleSignIn(data: data), success: { (response) in
//            do {
//                let responseModel =  try JSONDecoder().decode(ResponseModel<Account>.self,from: response.data)
//                switch responseModel.statusCode {
//                case 2000:
//                    onSuccess(responseModel)
//
//                default:
//                    onError(LoginError.athenticationFailure)
//                    break
//                }
//            } catch {
//                print(error)
//            }
//        })
//    }
//    
//    func getAllFranchises(data: [String: Any], onSuccess: @escaping (ResponseModel<Franchise>?) -> Void, onError: @escaping (LoginError) -> Void) {
//
//        NetworkAdapter.request(target: .getAllFranchises(data: data), success: { (response) in
//            do {
//                let responseModel =  try JSONDecoder().decode(ResponseModel<Account>.self,from: response.data)
//                switch responseModel.statusCode {
//                case 2000:
//                    onSuccess(responseModel)
//
//                default:
//                    onError(LoginError.athenticationFailure)
//                    break
//                }
//            } catch {
//                print(error)
//            }
//        })
//    }
//
//    func getAllStoreOwners(data: [String: Any], onSuccess: @escaping (ResponseModel<StoreOwner>?) -> Void, onError: @escaping (LoginError) -> Void) {
//
//        NetworkAdapter.request(target: .getAllStoreOwners(data: data), success: { (response) in
//            do {
//                let responseModel =  try JSONDecoder().decode(ResponseModel<Account>.self,from: response.data)
//                switch responseModel.statusCode {
//                case 2000:
//                    onSuccess(responseModel)
//
//                default:
//                    onError(LoginError.athenticationFailure)
//                    break
//                }
//            } catch {
//                print(error)
//            }
//        })
//    }
//}
//
//
