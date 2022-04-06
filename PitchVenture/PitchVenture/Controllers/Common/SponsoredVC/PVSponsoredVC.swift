//
//  PVSponsoredVC.swift
//  PitchVenture
//
//  Created by Harshit on 14/02/22.
//  Copyright © 2022 PitchVenture. All rights reserved.
//

import StoreKit
import UIKit

enum PVIAPHandlerAlertType {
    case setProductIds
    case disabled
    case restored
    case purchased
    
    var message: String{
        switch self {
        case .setProductIds: return "Product ids not set, call setProductIds method!"
        case .disabled: return "Purchases are disabled in your device!"
        case .restored: return "You've successfully restored your purchase!"
        case .purchased: return "You've successfully bought this purchase!"
        }
    }
}

class PVSponsoredVC: PVBaseVC {

    
    @IBOutlet weak var btnUpgrade: UIButton!
    @IBOutlet weak var btnNotNow: UIButton!
    
    fileprivate var productIds = ["com.georgiancollege.pitchventure.premiumsponsored"]
    fileprivate var arrSKProductIds = [SKProduct]()
    fileprivate var productID = "com.georgiancollege.pitchventure.premiumsponsored"
    fileprivate var productsRequest = SKProductsRequest()
    fileprivate var fetchProductComplition: (([SKProduct])->Void)?
    
    fileprivate var productToPurchase: SKProduct?
    fileprivate var purchaseProductComplition: ((PVIAPHandlerAlertType, SKProduct?, SKPaymentTransaction?)->Void)?
    
    var account : Account = Account()   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.account = PVUserManager.sharedManager().activeUser
//        self.setProductIds(ids: self.productIds)
        
        self.fetchAvailableProducts { [weak self](products)   in
           guard let sSelf = self else {return}
            sSelf.arrSKProductIds = products
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setLeftBarButton()
        self.setNavigationTitle("Upgrade Premium")
    }
    
    class func instantiate() -> PVSponsoredVC {
        return UIStoryboard.main().instantiateViewController(withIdentifier: PVSponsoredVC.identifier()) as! PVSponsoredVC
    }
    
    @IBAction func btnUpgradeAction(_ sender: Any) {
        //API TO UPGRADE
        
        self.purchase(product: self.arrSKProductIds[0]) { (alert, product, transaction) in
            
           if let tran = transaction, let prod = product {
             //use transaction details and purchased product as you want
               //SAVE IT TO USER's PROFILE
               print(tran)
               print(prod)
               
           }
            self.showAlertWithMessage(msg: alert.message)
           }

    }
    
    @IBAction func btnNotNowAction(_ sender: Any) {
        self.popController(vc: nil)
    }
}

extension PVSponsoredVC {
    //Set Product Ids
    func setProductIds(ids: [String]) {
        self.productIds = ids
    }
    
    //MAKE PURCHASE OF A PRODUCT
    func canMakePurchases() -> Bool {  return SKPaymentQueue.canMakePayments()  }
    
    func purchase(product: SKProduct, complition: @escaping ((PVIAPHandlerAlertType, SKProduct?, SKPaymentTransaction?)->Void)) {
        
        self.purchaseProductComplition = complition
        self.productToPurchase = product
        
        if self.canMakePurchases() {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().add(payment)
            
            print("PRODUCT TO PURCHASE: \(product.productIdentifier)")
            productID = product.productIdentifier
        }
        else {
            complition(PVIAPHandlerAlertType.disabled, nil, nil)
        }
    }
    
    // RESTORE PURCHASE
    func restorePurchase(){
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    
    // FETCH AVAILABLE IAP PRODUCTS
    func fetchAvailableProducts(complition: @escaping (([SKProduct])->Void)){
        
        productsRequest = SKProductsRequest(productIdentifiers: Set(self.productIds))
        productsRequest.delegate = self
        productsRequest.start()
        
        self.fetchProductComplition = complition
        
        // Put here your IAP Products ID's
//        if self.productIds.isEmpty {
//            print(PVIAPHandlerAlertType.setProductIds.message)
//            fatalError(PVIAPHandlerAlertType.setProductIds.message)
//        }
//        else {
//            productsRequest = SKProductsRequest(productIdentifiers: Set(self.productIds))
//            productsRequest.delegate = self
//            productsRequest.start()
//        }
    }
}

extension PVSponsoredVC : SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    // REQUEST IAP PRODUCTS
    func productsRequest (_ request:SKProductsRequest, didReceive response:SKProductsResponse) {
        
        if (response.products.count > 0) {
            if let complition = self.fetchProductComplition {
                complition(response.products)
            }
        }
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        if let complition = self.purchaseProductComplition {
            complition(PVIAPHandlerAlertType.restored, nil, nil)
        }
    }
    
    // IAP PAYMENT QUEUE
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction:AnyObject in transactions {
            if let trans = transaction as? SKPaymentTransaction {
                switch trans.transactionState {
                case .purchased:
                    print("Product purchase done")
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    if let complition = self.purchaseProductComplition {
                        complition(PVIAPHandlerAlertType.purchased, self.productToPurchase, trans)
                        var parameters = [String: Any]()
                        parameters = [
                            "accountId": self.account.id,
                            "isProfileSponsored": true
                        ]
                        if let isFranchise = self.account.isFranchise, isFranchise {
                            self.franchisorUpdate(parameters: parameters)
                        }else{
                            self.storeOwenerUpdate(parameters: parameters)
                        }
                            
                    }
                    break
                    
                case .failed:
                    print("Product purchase failed")
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    break
                case .restored:
                    print("Product restored")
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    break
                    
                default: break
                }}}
    }
}
