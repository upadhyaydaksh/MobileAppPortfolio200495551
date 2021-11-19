//
//  PVBaseVC.swift
//  PitchVenture
//
//  Created by Harshit on 25/10/21.
//  Copyright © 2021 PitchVenture. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

class PVBaseVC: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: - View Lifecycle

    var arrayForHiddenNavBarControllers: [AnyClass] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavBar()
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
    
    
    // MARK: - UIGestureRecognizerDelegate
    
//    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return true
//    }
    
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
                setLeftBarButtonWithImageName(imageName: "back_white.png")
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
        SVProgressHUD.dismiss()
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
    
}

extension UIViewController {
    var isModal: Bool {

        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController

        return presentingIsModal || presentingIsNavigation || presentingIsTabBar
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
