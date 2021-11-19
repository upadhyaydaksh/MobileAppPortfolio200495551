//
//  NetworkManager.swift
//
//  Created by Pawan Joshi on 20/02/16.
//  Copyright © 2019 PHYX. All rights reserved.
//

import UIKit

public enum HTTPRequestErrorCode: Int {
    
    case httpConnectionError = 40 // Trouble connecting to Server.
    case httpInvalidRequestError = 50 // Your request had invalid parameters.
    case httpResultError = 60 // API result error (eg: Invalid username and password).
}

class RequestManager: NSObject {
    
    fileprivate var _urlSession: URLSession?
    fileprivate var _runningURLRequests: NSSet?
    
    static var networkFetchingCount: Int = 0
    
    // MARK: - Class Methods
    
    static func beginNetworkActivity() -> () {
        networkFetchingCount += 1
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    /**
     Call to hide network indicator in Status Bar
     */
    static func endNetworkActivity() -> () {
        if networkFetchingCount > 0 {
            networkFetchingCount -= 1
        }
        
        if networkFetchingCount == 0 {
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
    
    // MARK: - Singleton Instance
    fileprivate static let _sharedManager = RequestManager()
    
    class func sharedManager() -> RequestManager {
        return _sharedManager
    }
    
    fileprivate override init() {
        super.init()
        // customize initialization
    }
    
    // MARK: - Private Methods
    /**
     Craete Urlsession from default configuration.
     
     - returns: instance of Url Session.
     */
    fileprivate func urlSession() -> URLSession {
        if _urlSession == nil {
            _urlSession = URLSession(configuration: URLSessionConfiguration.default)
            //            _urlSession?.sessionDescription! = "networkmanager.nsurlsession"
        }
        return _urlSession!
    }
    
    /**
     Setting Authorization HTTP Request Header
     */
    func setAuthorizationHeader() -> Void {
        // TODO: uncomment when using authorization header
        // Set the http header field for authorization
        //setValue("Token token=usertoken", forHTTPHeaderField: "Authorization")
    }
    
    // MARK: - Public Methods
    /**
     Perform request to fetch data
     
     - parameter request:           request
     - parameter userInfo:          userinfo
     - parameter completionHandler: handler
     */
    func performRequest(_ request: URLRequest, userInfo: NSDictionary? = nil, completionHandler: @escaping (_ response: Response) -> Void) -> () {
        
        debugPrint("URL: \(String(describing: request.url))")
        
        guard isNetworkReachable() else {
            let resError: NSError = errorForNoNetwork()
            let res = Response(error: resError)
            completionHandler(res)
            return // do not proceed if user is not connected to internet
        }
        
        
        var mutableRequest: URLRequest  = request

        //   Set required headers
        if PVUserManager.sharedManager().isUserLoggedIn() {
            mutableRequest.addValue(PVUserManager.sharedManager().activeUser.accessToken!, forHTTPHeaderField: "token")
            
        }
        mutableRequest.addValue(Constants.AppInfo.appVersion, forHTTPHeaderField: "app_version")
        mutableRequest.addValue(DeviceType.iOS.rawValue, forHTTPHeaderField: "device_type")
        mutableRequest.addValue(currentTimeZone(), forHTTPHeaderField: "time_zone")
        debugPrint("Header: \(String(describing: mutableRequest.allHTTPHeaderFields))")
        
        self.performSessionDataTaskWithRequest(mutableRequest, completionHandler: completionHandler)
    }
    
    /**
     Perform request to fetch data
     
     - parameter request:           request
     - parameter userInfo:          userinfo
     - parameter completionHandler: handler
     */
    fileprivate func performDownloadRequest(_ request: URLRequest, userInfo: NSDictionary? = nil, completionHandler: @escaping (_ response: Response) -> Void) -> () {
        guard isNetworkReachable() else {
            let resError: NSError = errorForNoNetwork()
            let res = Response(error: resError)
            completionHandler(res)
            return // do not proceed if user is not connected to internet
        }
        
        
        var mutableRequest: URLRequest  = request
        
        //   Set required headers
        if PVUserManager.sharedManager().isUserLoggedIn() {
            mutableRequest.addValue(PVUserManager.sharedManager().activeUser.accessToken!, forHTTPHeaderField: "token")
            
        }
        mutableRequest.addValue(Constants.AppInfo.appVersion, forHTTPHeaderField: "app_version")
        mutableRequest.addValue(currentTimeZone(), forHTTPHeaderField: "time_zone")
        mutableRequest.addValue(DeviceType.iOS.rawValue, forHTTPHeaderField: "device_type")
        debugPrint("Header: \(String(describing: mutableRequest.allHTTPHeaderFields))")
        
        RequestManager.beginNetworkActivity()
        self.addRequestedURL(mutableRequest.url!)
        let session: URLSession = self.urlSession()
        
        session.dataTask(with: mutableRequest, completionHandler: { (data, response, error) in
            RequestManager.endNetworkActivity()
            var responseError: Error? = error
            // handle http response status
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode > 299 {
                    responseError = self.errorForStatus(httpResponse.statusCode)
                }
            }
            var apiResponse: Response?
            if let _ = responseError {
                apiResponse = Response(data: data)
                if let _ = apiResponse?.resultDictionary {
                    self.logResponse(data!, responseDictnionary: apiResponse!.resultDictionary!, forRequest: mutableRequest)
                }
                //apiResponse = Response(error: responseError)
                apiResponse?.responseError = responseError
                if let _ = apiResponse?.responseError {
                    self.logError(apiResponse!.responseError!, request: mutableRequest)
                }
                
            } else {
                apiResponse = Response()
                apiResponse?.responseData = data
                apiResponse?.resultDictionary = ["status": 1, "message": "Downloaded successfully"]
                debugPrint("URL: \(String(describing: request.url?.absoluteString))")
            }
            
            self.removeRequestedURL(mutableRequest.url!)
            DispatchQueue.main.async(execute: { () -> Void in
                completionHandler(apiResponse!)
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 401 {
                        // User logged in somewhere else
                        PVUserManager.sharedManager().setSplashAsRoot()
                    } else if httpResponse.statusCode == 405 {
                        // User is using an old version of the app. Please show alert of app update.
                        PVUserManager.sharedManager().setSplashAsRoot()
                        let response = Response(data: data)
                        if let result = response.resultDictionary {
                            if let info = result.value(forKey: "data") as? [String : Any] {
                                if let platform = info["platform"] as? String {
                                    if platform == DeviceType.iOS.rawValue {
                                        print(data)
                                    }
                                }
                            }
                        }
                    }
                }
            })
        }) .resume()
    }
    
    /**
     Perform session data task
     
     - parameter request:           url request
     - parameter userInfo:          user information
     - parameter completionHandler: completion handler
     */
    fileprivate func performSessionDataTaskWithRequest(_ request: URLRequest, userInfo: NSDictionary? = nil, completionHandler: @escaping (_ response: Response) -> Void) -> () {
        
        RequestManager.beginNetworkActivity()
        self.addRequestedURL(request.url!)
        let session: URLSession = self.urlSession()
        
        session.dataTask(with: request, completionHandler: { (data, response, error) in
            
            if data != nil {
                let dataString = String(data: data!, encoding: String.Encoding.utf8) ?? "Data could not be printed"
                debugPrint("Response Data: \(dataString)")
            }
            
            RequestManager.endNetworkActivity()
            var responseError: Error? = error
            // handle http response status
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode > 299 {
                    responseError = self.errorForStatus(httpResponse.statusCode)
                }
            }
            var apiResponse: Response?
            if let _ = responseError {
                apiResponse = Response(data: data)
                if let _ = apiResponse?.resultDictionary {
                    self.logResponse(data!, responseDictnionary: apiResponse!.resultDictionary!, forRequest: request)
                }
                //apiResponse = Response(error: responseError)
                apiResponse?.responseError = responseError
                if let _ = apiResponse?.responseError {
                    self.logError(apiResponse!.responseError!, request: request)
                }
                
            } else {
                apiResponse = Response(data: data)
                if let _ = apiResponse?.resultDictionary {
                    self.logResponse(data!, responseDictnionary: apiResponse!.resultDictionary!, forRequest: request)
                }
                
            }
            
            self.removeRequestedURL(request.url!)
            DispatchQueue.main.async(execute: { () -> Void in
                completionHandler(apiResponse!)
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 401 {
                        // User logged in somewhere else
                        PVUserManager.sharedManager().setSplashAsRoot()
                    } else if httpResponse.statusCode == 405 {
                        // User is using an old version of the app. Please show alert of app update.
                        PVUserManager.sharedManager().setSplashAsRoot()
                        let response = Response(data: data)
                        if let result = response.resultDictionary {
                            if let info = result.value(forKey: "data") as? [String : Any] {
                                print(data)
                            }
                        }
                    }
                }
            })
        }) .resume()
    }
    
    /**
     Perform http action for a method
     
     - parameter method:            HTTP method
     - parameter urlString:         url string
     - parameter params:            parameters
     - parameter completionHandler: completion handler
     */
    func performHTTPActionWithMethod(_ method: HTTPRequestMethod, urlString: String, params: [String: AnyObject]? = nil, completionHandler: @escaping (_ response: Response) -> Void) {
        
        debugPrint("URL: \(urlString)")
        debugPrint("Params: \(String(describing: params))")
        
        if method == .GET {
            var components = URLComponents(string: urlString)
            components?.queryItems = params?.queryItems() as [URLQueryItem]?
            
            if let url = components?.url {
                var request = URLRequest(url: url)
                request.httpMethod = HTTPRequestMethod.GET.rawValue
                self.performRequest(request, completionHandler: completionHandler)
            } else { // do not proceed if the url is nil
                let resError: Error = errorForInvalidURL()
                let res = Response(error: resError)
                completionHandler(res)
            }
        } else {
            if let theJSONData = try? JSONSerialization.data(
                withJSONObject: params!,
                options: []) {
                
                let theJSONText = String(data: theJSONData,
                                         encoding: .utf8)
                debugPrint("JSON string = \(theJSONText!)")
                let request = URLRequest.requestWithURL(URL(string: urlString)!, method: method, body: theJSONText!)
                self.performRequest(request, completionHandler: completionHandler)
            }
            //let request = URLRequest.requestWithURL(URL(string: urlString)!, method: method, jsonDictionary: params as NSDictionary?)
            //self.performRequest(request, completionHandler: completionHandler)
        }
    }
    
    /**
     Perform Download of data
     
     - parameter method:            HTTP method
     - parameter urlString:         url string
     - parameter params:            parameters
     - parameter completionHandler: completion handler
     */
    func performDownload(urlString: String, params: [String: AnyObject]? = nil, completionHandler: @escaping (_ response: Response) -> Void) {
        var components = URLComponents(string: urlString)
        components?.queryItems = params?.queryItems() as [URLQueryItem]?
        
        if let url = components?.url {
            var request = URLRequest(url: url)
            request.httpMethod = HTTPRequestMethod.GET.rawValue
            self.performDownloadRequest(request, completionHandler: completionHandler)
        } else { // do not proceed if the url is nil
            let resError: Error = errorForInvalidURL()
            let res = Response(error: resError)
            completionHandler(res)
        }
    }
    
    fileprivate func logError(_ error: Error, request: URLRequest) {
        #if DEBUG
            debugPrint("URL: \(String(describing: request.url?.absoluteString)) Error: \(error.localizedDescription)")
        #endif
    }
    
    fileprivate func logResponse(_ data: Data, responseDictnionary: NSDictionary, forRequest request: URLRequest) {
        #if DEBUG
            debugPrint("Data Size: \(data.count) bytes")
            //let output: NSString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)!
            if PVUserManager.sharedManager().isUserLoggedIn() {
                debugPrint("token: \(PVUserManager.sharedManager().activeUser.accessToken!)")
            }
            debugPrint("appversion: \(Constants.AppInfo.appVersion)")
            debugPrint("devicetype: \(DeviceType.iOS.rawValue)")
            debugPrint("URL: \(String(describing: request.url?.absoluteString))")
            debugPrint("Output: \(responseDictnionary)")
        #endif
    }
}

// MARK: Request handling methods
extension RequestManager {
    
    /**
     Add a Url to request Manager.
     
     - parameter url: URL
     */
    fileprivate func addRequestedURL(_ url: URL) {
        objc_sync_enter(self)
        let requests: NSMutableSet = (self.runningURLRequests().mutableCopy()) as! NSMutableSet
        requests.add(url)
        _runningURLRequests = requests
        objc_sync_exit(self)
    }
    
    /**
     Remove url from Manager.
     
     - parameter url: URL
     */
    fileprivate func removeRequestedURL(_ url: URL) {
        objc_sync_enter(self)
        let requests: NSMutableSet = (self.runningURLRequests().mutableCopy()) as! NSMutableSet
        if requests.contains(url) == true {
            requests.remove(url)
            _runningURLRequests = requests
        }
        objc_sync_exit(self)
    }
    
    /**
     get currently running requests
     
     - returns: return set of running requests
     */
    fileprivate func runningURLRequests() -> NSSet {
        if _runningURLRequests == nil {
            _runningURLRequests = NSSet()
        }
        return _runningURLRequests!
    }
    
    /**
     Check wheather requesting fro URL.
     
     - parameter URl: url to check.
     
     - returns: true if current request.
     */
    fileprivate func isProcessingURL(_ url: URL) -> Bool {
        return self.runningURLRequests().contains(url)
    }
    
    /**
     Cancel session for a URL.
     
     - parameter url: URL
     */
    func cancelRequestForURL(_ url: URL) {
        self.urlSession().getTasksWithCompletionHandler({ (dataTasks: [URLSessionDataTask], uploadTasks: [URLSessionUploadTask], downloadTasks: [URLSessionDownloadTask]) -> Void in
            
            let capacity: NSInteger = dataTasks.count + uploadTasks.count + downloadTasks.count
            let tasks: NSMutableArray = NSMutableArray(capacity: capacity)
            tasks.addObjects(from: dataTasks)
            tasks.addObjects(from: uploadTasks)
            tasks.addObjects(from: downloadTasks)
            let predicate: NSPredicate = NSPredicate(format: "originalRequest.URL = %@", url as CVarArg)
            tasks.filter(using: predicate)
            
            for task in tasks {
                (task as! URLSessionTask).cancel()
            }
        })
    }
    
    /**
     Cancel All Running Requests
     */
    func cancelAllRequests() {
        self.urlSession().invalidateAndCancel()
        _urlSession = nil
        _runningURLRequests = nil
    }
}

// MARK: Error handling methods
extension RequestManager {
    
    /**
     Get Error instances if Nil URL.
     
     - returns: Error instance.
     */
    fileprivate func errorForInvalidURL() -> NSError {
        let errorDictionary = [NSLocalizedFailureReasonErrorKey : NSLocalizedString("URL Invalid", comment: "URL Invalid"), NSLocalizedDescriptionKey : NSLocalizedString("URL must not be nil", comment: "URL must not be nil")]
        return NSError(domain: NSURLErrorDomain, code: -1, userInfo: errorDictionary)
    }
    
    /**
     Get Error instances for NoNetwork.
     
     - returns: Error instance.
     */
    fileprivate func errorForNoNetwork() -> NSError {
        let errorDictionary = [NSLocalizedFailureReasonErrorKey : NSLocalizedString("Network unavailable", comment: "Network unavailable"), NSLocalizedDescriptionKey : NSLocalizedString("Network not available", comment: "Network not available")]
        return NSError(domain: NSURLErrorDomain, code: HTTPRequestErrorCode.httpConnectionError.rawValue, userInfo: errorDictionary)
    }
    
    /**
     Get Error instances for connectionError.
     
     - returns: connectionError instance.
     */
    fileprivate func connectionError() -> NSError {
        let errorDictionary = [NSLocalizedFailureReasonErrorKey : NSLocalizedString("Connection Error", comment: "Connection Error"), NSLocalizedDescriptionKey : NSLocalizedString("Network error occurred while performing this task. Please try again later.", comment: "Network error occurred while performing this task. Please try again later.")]
        return NSError(domain: kHTTPRequestDomain, code: HTTPRequestErrorCode.httpConnectionError.rawValue, userInfo: errorDictionary)
    }
    
    /**
     Create an error for response you probably don't want (400-500 HTTP responses for example).
     
     - parameter code: Code for error.
     
     - returns: An NSError.
     */
    fileprivate func errorForStatus(_ code: Int) -> NSError {
        let text = NSLocalizedString(HTTPStatusCode(statusCode: code).statusDescription, comment: "")
        let errorDictionary = [NSLocalizedFailureReasonErrorKey : NSLocalizedString("Error", comment: "Error"), NSLocalizedDescriptionKey : text]
        return NSError(domain: "HTTP", code: code, userInfo: errorDictionary)
    }
}

// MARK: Network reachable methods
extension RequestManager {
    
    /**
     Check wheather network is reachable.
     
     - returns: true is reachable otherwise false.
     */
    fileprivate func isNetworkReachable() -> Bool {
        return Reachability.instance.networkConnectionStatus() != .notConnection
    }
}
