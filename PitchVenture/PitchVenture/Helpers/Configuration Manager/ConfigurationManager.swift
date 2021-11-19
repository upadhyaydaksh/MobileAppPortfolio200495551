//
//  ConfigurationManager.swift
//
//  Created by Harshit on 15/11/21.
//  Copyright © 2021 PitchVenture. All rights reserved.
//

import UIKit

enum Configuration {
    case developement
    case production
}

enum CurrentApp {
    case userApp
    case contractorApp
}

enum Environment {
    case development
    case production
}

let kCurrentApp = ConfigurationManager.sharedManager().currentApp()

final class ConfigurationManager: NSObject {

    var environment: NSDictionary!

    // MARK: - Singleton Instance
    fileprivate static let _sharedManager = ConfigurationManager()

    class func sharedManager() -> ConfigurationManager {
        return _sharedManager
    }

    fileprivate override init() {
        super.init()

        // customize initialization
        initialize()
    }

    // MARK: Private Method

    fileprivate func initialize() {

        var environments: NSDictionary?
        if let envsPlistPath = Bundle.main.path(forResource: "Environments", ofType: "plist") {
            environments = NSDictionary(contentsOfFile: envsPlistPath)
        }

        self.environment = environments!.object(forKey: currentConfiguration()) as? NSDictionary

        if self.environment == nil {

            assertionFailure(NSLocalizedString("Unable to load application configuration", comment: "Unable to load application configuration"))
        }
    }

    // MARK: - Public Methods
    
    func configuration() -> Configuration {
        if self.currentConfiguration() == "Development" {
            return Configuration.developement
        } else {
            return Configuration.production
        }
    }

    func currentConfiguration() -> String {

        let configuration = Bundle.main.infoDictionary?["ActiveConfiguration"] as? String
        return configuration!
    }

    func APIEndPoint() -> String {

        let configuration = self.environment!["APIEndPoint"]
        return (configuration)! as! String
    }
    
    func URLEndPoint() -> String {
        
        let configuration = self.environment!["URLEndPoint"]
        return (configuration)! as! String
    }
    
    func UserImageEndPoint() -> String {
        
        let configuration = self.environment!["UserImageEndPoint"]
        return (configuration)! as! String
    }
    
    func CircleImageEndPoint() -> String {
        
        let configuration = self.environment!["CircleImageEndPoint"]
        return (configuration)! as! String
    }
    
    func googleAPIKey() -> String {
        
        let googleKey = self.environment!["GoogleAPIKey"]
        return (googleKey)! as! String
    }
    
    func googleClientID() -> String {
        
        let googleKey = self.environment!["GoogleClientID"]
        return (googleKey)! as! String
    }
    
    func googleClientIDReversed() -> String {
        
        let googleKey = self.environment!["GoogleClientIDReversed"]
        return (googleKey)! as! String
    }
    
    func requestNumberPrefix() -> String {
        
        let requestNumberPrefix = self.environment!["RequestNumberPrefix"]
        return (requestNumberPrefix)! as! String
    }

    func isLoggingEnabled() -> Bool {

        let configuration = self.environment!["LoggingEnabled"]
        return (configuration)! as! Bool
    }

    func isAnalyticsTrackingEnabled() -> String {

        let configuration = self.environment!["AnalyticsTrackingEnabled"]
        return (configuration)! as! String
    }
    
    func URIScheme() -> String {
        
        let scheme = self.environment!["URIScheme"]
        return (scheme)! as! String
    }
    
    func firebasePlistName() -> String {
        var pListName = ""
        if kCurrentApp == .contractorApp {
            pListName = "ContractorFirebasePlistName"
        } else {
            pListName = "UserFirebasePlistName"
        }
        let firebasePlistName = self.environment![pListName]
        return (firebasePlistName)! as! String
    }
    
    func currentApp() -> CurrentApp {
        guard let target = Bundle.main.infoDictionary?["Target"] as? String else { return .contractorApp }
        if target.lowercased().contains("contractor") {
            return .contractorApp
        }
        return .userApp
    }
    
    func currentEnvironment() -> Environment {
        
        let configuration = Bundle.main.infoDictionary?["ActiveConfiguration"] as? String
        if configuration == "Development" {
            return .development
        }
        return .production
    }
    
}

extension ConfigurationManager {

    // MARK: Facebook
    func facebookAppId() -> String {
        let facebookID = self.environment!["FacebookAppId"]

        if facebookID == nil {
            assert(facebookID != nil, "Please supply Facebook App ID in Project Directory > Library > Managers > Configration Manager -> Enviroments.plist")
            return ""
        } else {
            return facebookID as! String
        }
    }

    // MARK: Twitter
    func twitterAppId() -> (twitterClientID: String, twitterClientSecretID: String) {

        if let twitterAppID: NSDictionary? = self.environment!["TwitterAppID"] as? NSDictionary, twitterAppID!["TwitterClientID"] != nil && twitterAppID!["TwitterClientSecrateID"] != nil {
            return (twitterAppID!["TwitterClientID"] as! String, twitterAppID!["TwitterClientSecrateID"] as! String)
        } else {
            assertionFailure("Please supply Twitter Client ID and Twitter Client Secret ID in Project Directory > Library > Managers > Configration Manager -> Enviroments.plist")
            return ("", "")
        }
    }

    // MARK: LinkedIn
    func linkedInAppId() -> String {
        let linkedInAppId = self.environment!["LinkedInAppId"]
        if linkedInAppId == nil {
            assert(linkedInAppId != nil, "Please supply Linked In App ID in Project Directory > Library > Managers > Configration Manager -> Enviroments.plist")
            return ""
        } else {
            return linkedInAppId as! String
        }
    }
}

extension ConfigurationManager {
    // MARK: ZoomSDK
    func zoomAppKey() -> String {
        let value = self.environment!["ZoomAppKey"]
        return (value)! as! String
    }
    
    func zoomAppSecretKey() -> String {
        let value = self.environment!["ZoomAppSecretKey"]
        return (value)! as! String
    }
    
    func webSocketURL() -> String {
        let value = self.environment!["WebSocketURL"]
        return (value)! as! String
    }
}
