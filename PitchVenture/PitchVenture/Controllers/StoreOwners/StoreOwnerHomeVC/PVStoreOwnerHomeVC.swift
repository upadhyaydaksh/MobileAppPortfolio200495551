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
    
    private var adInterstitial: GADInterstitialAd?
    
    //MARK: - Class Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerTableViewCell()
        
        self.getAppData()
        self.showAdBanner()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.removeLeftBarButton()
        self.setNavigationTitle("Home")
        self.account = PVUserManager.sharedManager().activeUser
        
        if let isFranchise = self.account.isFranchise, isFranchise {
            if let isProfileSponsored = self.account.franchise?.isProfileSponsored, isProfileSponsored {
                //USER IS ALREADY SPONSORED SO DONT SHOW HIM BUTTON IN NAVBAR
                self.setProfileNavBarButton()
            } else {
                //USER IS NOT SPONSORED SO SHOW HIM BUTTON IN NAVBAR
                self.setProfileAndNotificationNavBarButton()
            }
        } else {
            if let isProfileSponsored = self.account.storeOwner?.isProfileSponsored, isProfileSponsored {
                //USER IS ALREADY SPONSORED SO DONT SHOW HIM BUTTON IN NAVBAR
                self.setProfileNavBarButton()
            } else {
                //USER IS NOT SPONSORED SO SHOW HIM BUTTON IN NAVBAR
                self.setProfileAndNotificationNavBarButton()
            }
        }
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
            if self.adInterstitial != nil {
                self.adInterstitial?.present(fromRootViewController: self)
            } else {
                print("Ad wasn't ready")
            }
        }
    }
    
    class func instantiate() -> PVStoreOwnerHomeVC {
        return UIStoryboard.main().instantiateViewController(withIdentifier: PVStoreOwnerHomeVC.identifier()) as! PVStoreOwnerHomeVC
    }
    
    func registerTableViewCell() {
        tableView.register(UINib(nibName: "PVHomeTableViewCell", bundle: nil), forCellReuseIdentifier: PVHomeTableViewCell.reuseIdentifier())
    }
    
    func showAdBanner() {
        
        let request = GADRequest()
        //TEST :- ca-app-pub-3940256099942544/4411468910
        //LIVE :- ca-app-pub-8620133611536867/6791863776
        GADInterstitialAd.load(withAdUnitID:"ca-app-pub-8620133611536867/6791863776",
                               request: request,
                               completionHandler: { [self] ad, error in
            if let error = error {
                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                return
            }
            adInterstitial = ad
            adInterstitial?.fullScreenContentDelegate = self
        }
        )
    }
}

extension PVStoreOwnerHomeVC: GADFullScreenContentDelegate {
    /// Tells the delegate that the ad failed to present full screen content.
      func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Ad did fail to present full screen content.")
      }

      /// Tells the delegate that the ad will present full screen content.
      func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad will present full screen content.")
      }

      /// Tells the delegate that the ad dismissed full screen content.
      func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did dismiss full screen content.")
      }
}
