//
//  PVStoreOwnerHomeVC.swift
//  PitchVenture
//
//  Created by Harshit on 18/11/21.
//  Copyright © 2021 PitchVenture. All rights reserved.
//

import GoogleMobileAds
import UIKit

class PVStoreOwnerHomeVC: PVBaseVC {

    //MARK: - Outlets
    
    var bannerView: GADBannerView!
    
    var arrFranchises : [Account] = []
    var arrAppData : [AppData] = []
    
    var account : Account = Account()
    
    @IBOutlet weak var tableView: UITableView!
    
    let adSize = GADAdSizeFromCGSize(CGSize(width: SCREEN_WIDTH - 20, height: 64))
    
    //MARK: - Class Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerTableViewCell()
        
        self.getAppData()
        
        bannerView = GADBannerView(adSize: adSize)
        addBannerViewToView(bannerView)
        //TEST
        //bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        //LIVE
        bannerView.adUnitID = "ca-app-pub-8620133611536867/7249942660"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        bannerView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.removeLeftBarButton()
        self.setNavigationTitle("Home")
        self.setProfileAndNotificationNavBarButton()
    }
    
    class func instantiate() -> PVStoreOwnerHomeVC {
        return UIStoryboard.main().instantiateViewController(withIdentifier: PVStoreOwnerHomeVC.identifier()) as! PVStoreOwnerHomeVC
    }
    
    func registerTableViewCell() {
        tableView.register(UINib(nibName: "PVHomeTableViewCell", bundle: nil), forCellReuseIdentifier: PVHomeTableViewCell.reuseIdentifier())
    }
    
}

extension PVStoreOwnerHomeVC: GADBannerViewDelegate {
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
    
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("bannerViewDidReceiveAd")
        self.addBannerViewToView(bannerView)
    }
    
    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
        print("bannerViewDidRecordImpression")
    }
    
    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("bannerViewWillPresentScreen")
    }
    
    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("bannerViewWillDIsmissScreen")
    }
    
    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("bannerViewDidDismissScreen")
    }
}
