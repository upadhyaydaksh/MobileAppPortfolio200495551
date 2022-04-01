//
//  PVLoginVC.swift
//  PitchVenture
//
//  Created by Harshit on 25/10/21.
//  Copyright © 2021 PitchVenture. All rights reserved.
//

import UIKit
import AuthenticationServices
import GoogleSignIn

class PVLoginVC: PVBaseVC {

    let signInConfig = GIDConfiguration.init(clientID: Constants.googleClientId)
    
    var account : Account = Account()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    // MARK: - Class Methods
    
    class func instantiate() -> PVLoginVC {
        return UIStoryboard.main().instantiateViewController(withIdentifier: PVLoginVC.identifier()) as! PVLoginVC
    }
    
    func performExistingAccountSetupFlows() {
        // Prepare requests for both Apple ID and password providers.
        let requests = [ASAuthorizationAppleIDProvider().createRequest(),
                        ASAuthorizationPasswordProvider().createRequest()]
        
        // Create an authorization controller with the given requests.
        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    /// - Tag: perform_appleid_request
    @objc
    func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
    }
    
    @IBAction func btnAppleLoginAction(_ sender: Any) {
        handleAuthorizationAppleIDButtonPress()
    }
    
    @IBAction func btnGoogleLoginAction(_ sender: Any) {
        
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
          guard error == nil else { return }

            print(user?.authentication.idToken ?? "N.A.")
            
            //CHECK IF USER IS ALREADY SIGNED UP OR NOT
            self.callCreateUser(tokenID: user?.authentication.idToken)
        }
    }
}

extension PVLoginVC: ASAuthorizationControllerDelegate {
    /// - Tag: did_complete_authorization
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            // Create an account in your system.
            let userIdentifier = appleIDCredential.user
            let familyName = appleIDCredential.fullName?.familyName
            let givenName = appleIDCredential.fullName?.givenName
            let email = appleIDCredential.email
            let token = appleIDCredential.identityToken
            let tokenString = String(data: token!, encoding: .utf8)
            self.callCreateUserWithAppleSignIn(token: tokenString, email: email, appleUserId: userIdentifier, givenName:givenName, familyName: familyName)
            // For the purpose of this demo app, store the `userIdentifier` in the keychain.
            self.saveUserInKeychain(userIdentifier)
            
            // For the purpose of this demo app, show the Apple ID credential information in the `ResultViewController`.
//            self.showResultViewController(userIdentifier: userIdentifier, fullName: fullName, email: email)
        
        case let passwordCredential as ASPasswordCredential:
        
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            // For the purpose of this demo app, show the password credential as an alert.
            DispatchQueue.main.async {
                PVMessage.showSuccessWithMessage(message: "Successfully logged in.")
                //self.showPasswordCredentialAlert(username: username, password: password)
            }
            
        default:
            break
        }
    }
    
    private func saveUserInKeychain(_ userIdentifier: String) {
        do {
            try KeychainItem(service: "com.georgiancollege.pitchventure", account: "userIdentifier").saveItem(userIdentifier)
        } catch {
            print("Unable to save userIdentifier to keychain.")
        }
    }
    
    private func showResultViewController(userIdentifier: String, fullName: PersonNameComponents?, email: String?) {
        
        DispatchQueue.main.async {
            if let givenName = fullName?.givenName {
                print(givenName)
            }
            if let familyName = fullName?.familyName {
                print(familyName)
            }
            if let email = email {
                print(email)
            }
        }
    }
    
//    private func showPasswordCredentialAlert(username: String, password: String) {
//        let message = "The app has received your selected credential from the keychain. \n\n Username: \(username)\n Password: \(password)"
//        let alertController = UIAlertController(title: "Keychain Credential Received",
//                                                message: message,
//                                                preferredStyle: .alert)
//        alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
//        self.present(alertController, animated: true, completion: nil)
//    }
    
    /// - Tag: did_complete_error
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
}

extension PVLoginVC: ASAuthorizationControllerPresentationContextProviding {
    /// - Tag: provide_presentation_anchor
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
