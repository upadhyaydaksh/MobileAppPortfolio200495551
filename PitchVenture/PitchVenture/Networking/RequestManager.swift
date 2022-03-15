//
//  RequestManager.swift
//  PitchVenture
//
//  Created by Harshit on 2022-02-18.
//  Copyright © 2022 PitchVenture. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class RequestManager: Alamofire.SessionManager {
    
    public typealias NetworkSuccessHandler = (DataResponse<Any>) -> Void
    public typealias NetworkFailureHandler = (DataResponse<Any>, Error) -> Void
        
    // MARK: - Initialization methods
    
    static let sharedInstance: RequestManager = {
        let configuration = URLSessionConfiguration.default // or your configuration
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        let instance = RequestManager(configuration: configuration, delegate: SessionManager.default.delegate)
        instance.initialize()
        return instance
    }()
    
    func initialize () {
        
    }

    func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    func JSONStringify(value: AnyObject,prettyPrinted:Bool = false) -> String{
        let options = prettyPrinted ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions(rawValue: 0)
        if JSONSerialization.isValidJSONObject(value) {
            do {
                let data = try JSONSerialization.data(withJSONObject: value, options: options)
                if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    return string as String
                }
            } catch {
                // print("error")
                //Access error here
            }
        }
        return ""
    }
    
    public func startRequest(url:URLConvertible,
                             method:HTTPMethod,
                             params:Parameters?,
                             encoding:ParameterEncoding,
                             headers:HTTPHeaders? = nil,
                             success: NetworkSuccessHandler?,
                             failure: NetworkFailureHandler?) -> Request? {
        
        var authHeader:HTTPHeaders = [:]
        let urlString = url as? String
        
        let account = PVUserManager.sharedManager().activeUser
        if let accountToken = account?.token {
            authHeader = ["Authorization": "Bearer " + accountToken.trimmedString(),
                          "Content-Type" : "application/json"]
        }
        
        print("authHeader +++++++++++ \(authHeader)")
        
        let jsonString = JSONStringify(value: params as AnyObject, prettyPrinted: true)
        print("Parameters :- \(jsonString)")
        
        //Modification to parameters and auth headers ended here
//        print("\n++++++++++ Parameters \(String(describing: params))\n")
        let req = Alamofire.request(url, method: method, parameters: params, encoding: encoding, headers: authHeader ).responseJSON {  response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    if (TARGET_OS_SIMULATOR == 1) {
                        print("\n++++++++++ JSON : \(json)\n")
                    }
                    success?(response)
                }
            case .failure(let error):
                if let data = response.data {
                    print("\n ++++++ Error Response data: \(String(data: data, encoding: String.Encoding.utf8)!)")
                }
                failure?(response, error)
            }
        }
        if (TARGET_OS_SIMULATOR == 1) {
            print(req)
        }
        return req
    }
    
    func callRespectiveGetWebservices(isSucces:@escaping (_ response :DataResponse<Any>) -> (),
                       isFailure:@escaping (_ isCancelled :Bool?,_ error:NSError?)->(), params: [String: Any], urlApi: String) {
        _ = self.startRequest(url: urlApi, method: .get, params: params, encoding: JSONEncoding.default, headers: nil, success: { (response) in
            CommonMethods.sharedInstance.hideHud()
            return isSucces(response)
        }) { (response, error) in
            CommonMethods.sharedInstance.hideHud()
            if error._code != NSURLErrorCancelled {
                return isFailure(false,error as NSError)
            }
            else{
                return isFailure(true,error as NSError)
            }
        }
    }
    
    func callRespectiveWebservices(isSucces:@escaping (_ response :DataResponse<Any>) -> (),
                       isFailure:@escaping (_ isCancelled :Bool?,_ error:NSError?)->(), params: [String: Any], urlApi: String) {
        _ = self.startRequest(url: urlApi, method: .post, params: params, encoding: JSONEncoding.default, headers: nil, success: { (response) in
            CommonMethods.sharedInstance.hideHud()
            return isSucces(response)
        }) { (response, error) in
            CommonMethods.sharedInstance.hideHud()
            if error._code != NSURLErrorCancelled {
                return isFailure(false,error as NSError)
            }
            else{
                return isFailure(true,error as NSError)
            }
        }
    }
    
    func callRespectivePutWebservices(isSucces:@escaping (_ response :DataResponse<Any>) -> (),
                       isFailure:@escaping (_ isCancelled :Bool?,_ error:NSError?)->(), params: [String: Any], urlApi: String) {
        _ = self.startRequest(url: urlApi, method: .put, params: params, encoding: JSONEncoding.default, headers: nil, success: { (response) in
            CommonMethods.sharedInstance.hideHud()
            return isSucces(response)
        }) { (response, error) in
            CommonMethods.sharedInstance.hideHud()
            if error._code != NSURLErrorCancelled {
                return isFailure(false,error as NSError)
            }
            else{
                return isFailure(true,error as NSError)
            }
        }
    }
    
    override init(configuration: URLSessionConfiguration, delegate: SessionDelegate, serverTrustPolicyManager: ServerTrustPolicyManager? = nil) {
        super.init(configuration: configuration, delegate: delegate, serverTrustPolicyManager: serverTrustPolicyManager)
    }
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func callCommonAPI(isSucces:@escaping (_ response :DataResponse<Any>) -> (),
                       isFailure:@escaping (_ isCancelled :Bool?,_ error:NSError?)->(), urlApi: String) {
        
        _ = self.startRequest(url: urlApi, method: .post, params: nil, encoding: JSONEncoding.default, headers: nil, success: { (response) in
            CommonMethods.sharedInstance.hideHud()
            return isSucces(response)
        }) { (response, error) in
            CommonMethods.sharedInstance.hideHud()
            if error._code != NSURLErrorCancelled {
                return isFailure(false,error as NSError)
            }
            else{
                return isFailure(true,error as NSError)
            }
        }
    }
}
