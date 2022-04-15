//
//  PVBaseVC.swift
//  PitchVenture
//
//  Created by Harshit on 25/10/21.
//  Copyright © 2021 PitchVenture. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

class PVBaseVC: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: - View Lifecycle

    var arrayForHiddenNavBarControllers: [AnyClass] = []
    
    let timeStamp = NSDate().timeIntervalSince1970
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavBar()
        //navigationController?.navigationBar.barTintColor = Constants.color.kApp_Blue_Color
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.black
        ]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        togglePopGestureForViewControllers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Status bar
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        // Don't handle button taps
        return !(touch.view is UIButton)
    }
    
    // MARK: - Popgesture
    
    func togglePopGestureForViewControllers() {
        if let count = self.navigationController?.viewControllers.count {
            if count > 1 {
                self.navigationController?.interactivePopGestureRecognizer?.delegate = self
                self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
            } else {
                self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
                self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
            }
        }
        
    }
    
    // MARK: - Back Button
    
    func configureNavBar() {
        
        self.navigationItem.hidesBackButton = true
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        if let _ = self.navigationController as? PVNavigationController {
            // Avoiding sub view controller to access this code
            let visibleViewController = self.navigationController?.viewControllers.last
            
            if self.navigationController!.viewControllers.count > 1 {
                setLeftBarButtonWithImageName(imageName: "ic_back_white.png")
            } else {
                removeLeftBarButton()
            }
            
            var navBarHidden = false
            for cls in arrayForHiddenNavBarControllers {
                if visibleViewController!.isKind(of: cls) {
                    navBarHidden = true
                    (self.navigationController as? PVNavigationController)?.hideNavigationBar()
                }
            }
            
        }
    }
    
    
    func setLeftBarButtonWithImageName(imageName: String) {
        let backButton = UIButton()
        backButton.setImage(UIImage(named:imageName), for: .normal)
        backButton.addTarget(self, action: #selector(actionBackTapped), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    func removeLeftBarButton() {
        self.navigationItem.leftBarButtonItem = nil
    }
    
    @objc func actionBackTapped() {
        CommonMethods.sharedInstance.hideHud()
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: - Tap Gesture
    
    func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(PVBaseVC.resign))
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
    }
    
    
    @objc func resign() {
        self.view.endEditing(true)
    }
    
    // MARK: - Navigation Title
    
    func setNavigationTitle(_ title: String) {
        self.navigationItem.title = title
    }
    
    func setLeftBarButton() {
        let logoutButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named:"ic_back-white.png"), style: .plain, target: self, action: #selector(PVBaseVC.actionBackTapped))
        self.navigationItem.setLeftBarButtonItems([logoutButton], animated: true)
    }
    
    func setNavigationImage(imageName: String) {
        let imageView = UIImageView(frame: CGRect(x: 120.0, y: 0.0, width: Constants.ScreenSize.SCREEN_WIDTH-240.0, height: 44.0))
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: imageName)
        self.navigationItem.titleView = imageView
    }
    
    func hideNavigationTitle() {
        
        self.navigationItem.title = ""
    }
    
    func push(vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func popController(vc: AnyClass?) {
        guard let vcClass = vc else {
            self.navigationController?.popViewController(animated: true)
            return
        }
        for vc in self.navigationController!.viewControllers {
            if vc.isKind(of: vcClass) {
                self.navigationController?.popToViewController(vc, animated: true)
                break
            }
        }
        
    }
    
    func popBackToCount(count: Int) {
        guard let total = self.navigationController?.viewControllers.count else {return}
        guard let toVC = self.navigationController?.viewControllers[total-count-1] else {return}
        self.navigationController?.popToViewController(toVC, animated: true)
    }
    
    func popToRootVC() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func convertJSONtoString(paramJSON : [String : Any] ) -> String {
        
        if let theJSONData = try? JSONSerialization.data(
            withJSONObject: paramJSON,
            options: []) {
            let theJSONText = String(data: theJSONData,
                                       encoding: .ascii)
            print("JSON string = \(theJSONText!)")
            return theJSONText!
        }
        
        return ""
    }
    
    func viewSlideInFromTopToBottom(views: UIView) {
        var transition: CATransition? = nil
        transition = CATransition()
        transition!.duration = 0.4
        transition!.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition!.type = CATransitionType.push
        transition!.subtype = CATransitionSubtype.fromTop
        views.layer.add(transition!, forKey: nil)
    }
    
    func viewSlideInFromBottomToTop(views: UIView) {
        var transition: CATransition? = nil
        transition = CATransition()
        transition!.duration = 0.4
        transition!.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition!.type = CATransitionType.push
        transition!.subtype = CATransitionSubtype.fromBottom
        views.layer.add(transition!, forKey: nil)
    }
    
    func setProfileNavBarButton() {
        let profileButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_user"), style: .plain, target: self, action: #selector(goToStoreOwnerProfileVC))
        profileButton.tintColor = Constants.color.kAPP_COLOR
        
        self.navigationItem.setRightBarButton(profileButton, animated: true)
    }
    
    func setProfileAndNotificationNavBarButton() {
        let profileButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_user"), style: .plain, target: self, action: #selector(goToStoreOwnerProfileVC))
        profileButton.tintColor = Constants.color.kAPP_COLOR
        
        let notificationButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_notification"), style: .plain, target: self, action: #selector(goToNotificationVC))
        notificationButton.tintColor = Constants.color.kAPP_COLOR
        
        let premiumButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_sponsored"), style: .plain, target: self, action: #selector(openSponsoredVC))
        premiumButton.tintColor = Constants.color.kAPP_COLOR
        
        //self.navigationItem.setRightBarButtonItems([profileButton,notificationButton, premiumButton], animated: true)
        let account = PVUserManager.sharedManager().activeUser
        
        if let isFranchise = account?.isFranchise, isFranchise {
            if let isProfileSponsored = account?.franchise?.isProfileSponsored, isProfileSponsored {
                //USER IS ALREADY SPONSORED SO DONT SHOW HIM BUTTON IN NAVBAR
                self.navigationItem.setRightBarButtonItems([profileButton], animated: true)
            } else {
                //USER IS NOT SPONSORED SO SHOW HIM BUTTON IN NAVBAR
                self.navigationItem.setRightBarButtonItems([profileButton, premiumButton], animated: true)
            }
        } else {
            if let isProfileSponsored = account?.storeOwner?.isProfileSponsored, isProfileSponsored {
                //USER IS ALREADY SPONSORED SO DONT SHOW HIM BUTTON IN NAVBAR
                self.navigationItem.setRightBarButtonItems([profileButton], animated: true)
            } else {
                //USER IS NOT SPONSORED SO SHOW HIM BUTTON IN NAVBAR
                self.navigationItem.setRightBarButtonItems([profileButton, premiumButton], animated: true)
            }
        }
        
        
    }
    
    @objc func goToStoreOwnerProfileVC() {
        let obj = PVStoreOwnerProfileVC.instantiate()
        self.push(vc: obj)
    }
    
    @objc func goToNotificationVC() {
        let obj = PVNotificationsVC.instantiate()
        self.push(vc: obj)
    }

    func setLogoutNavBarButton() {
        let profileButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_logout"), style: .plain, target: self, action: #selector(showLogoutConfirmation))
        profileButton.tintColor = Constants.color.kAPP_COLOR
        
        self.navigationItem.setRightBarButton(profileButton, animated: true)
    }
    
    func setLogoutAndPremiumNavBarButton() {
        let profileButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_logout"), style: .plain, target: self, action: #selector(showLogoutConfirmation))
        profileButton.tintColor = Constants.color.kAPP_COLOR
        
        let premiumButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_sponsored"), style: .plain, target: self, action: #selector(openSponsoredVC))
        premiumButton.tintColor = Constants.color.kAPP_COLOR
        
        self.navigationItem.setRightBarButtonItems([profileButton, premiumButton], animated: true)
        //self.navigationItem.setRightBarButtonItems([profileButton], animated: true)
    }
    
    @objc func openSponsoredVC() {
        let vc = PVSponsoredVC.instantiate()
        self.push(vc: vc)
    }
    
    @objc func showLogoutConfirmation() {
        
        let alert = UIAlertController(title: "Logout", message: kAreYouSureToLogout, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Logout", style: .default, handler: { (_) in
            PVUserManager.sharedManager().logout()
            let obj = PVLoginVC.instantiate()
            self.push(vc: obj)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithMessage(msg: String) {
        // Open option of add business / add fundraiser
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithTitleAndMessage(title: String, msg: String) {
        // Open option of add business / add fundraiser
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func convertIntToCurrencyAsString(intValue: Int) -> String {
        var stringVersion: String
        let cFormatter = NumberFormatter()
        cFormatter.usesGroupingSeparator = true
        cFormatter.numberStyle = .currency
        if let currencyString = cFormatter.string(from: NSNumber(value: intValue)) {
            stringVersion = currencyString
        } else {
            stringVersion = "Invalid Message"
        }
        return stringVersion
    }
    
    // MARK: - Progress HUD
    func showHud() {
        DispatchQueue.main.async{
            let progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
            progressHUD.label.text = "Loading.."
        }
    }
    
    func hideHud() {
        DispatchQueue.main.async{
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
}

extension UIViewController {
    var isModal: Bool {

        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController

        return presentingIsModal || presentingIsNavigation || presentingIsTabBar
    }
    
    class func identifier() -> String {
        return String(describing: self)
    }
}

extension UIDevice {
    var hasNotch: Bool {
        if #available(iOS 11.0, *) {
            let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
            return bottom > 0
        } else {
            return false
        }
        
    }
}
