//
//  PVFranchisorsSignupVC.swift
//  PitchVenture
//
//  Created by Daksh Upadhyay on 2022-02-22.
//  Copyright © 2022 PitchVenture. All rights reserved.
//

import UIKit
import IQDropDownTextField
import AVKit
import MobileCoreServices
import Firebase
import FirebaseStorage
import SDWebImage
import Alamofire

class PVFranchisorsSignupVC: PVBaseVC, IQDropDownTextFieldDelegate {

    @IBOutlet weak var txtFranchiseName: UITextField!
    
    @IBOutlet weak var txtMinimumDeposit: UITextField!
    
    @IBOutlet weak var txtFranchiseCategory: IQDropDownTextField!
    
    @IBOutlet weak var btnImagePicker: UIButton!
    @IBOutlet weak var imgLocation: UIImageView!
    @IBOutlet weak var btnSubmit: PVButton!
    
    var imagePicker = UIImagePickerController()
    
    var locationImage: UIImage?
    
    var account : Account = Account()
    
    var isFromEditProfile: Bool = false
    
    var arrAppData : [AppData] = []
    
    var arrSelectedCategory : [String] = []
    
    var itemList : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtFranchiseCategory.isOptionalDropDown = false
        
        self.getAppData()
        if self.isFromEditProfile {
            self.setNavigationTitle("Edit Franchise Details")
            self.autoFillData()
        } else {
            self.setNavigationTitle("Add Franchise Details")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setLeftBarButton()
        
        
    }
    
    func autoFillData() {
        
        self.txtFranchiseName.text = self.account.franchise?.franchiseName
        
        self.txtMinimumDeposit.text = "\(self.account.franchise?.minimumDeposit ?? 0)"
        
        self.imgLocation.sd_setImage(with: URL(string: (self.account.picture ?? "")), placeholderImage: UIImage(named: "ic_logo.png"))
        
    }
    
    
    // MARK: - Class Methods
    
    class func instantiate() -> PVFranchisorsSignupVC {
        return UIStoryboard.main().instantiateViewController(withIdentifier: PVFranchisorsSignupVC.identifier()) as! PVFranchisorsSignupVC
    }
    
    //MARK: - Class Methods
    @IBAction func btnImagePickerAction(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Upload Photo", message: "Select an option", preferredStyle: .actionSheet)
                
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
            self.selectImage(sourceType: .camera)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (_) in
            self.selectImage(sourceType: .photoLibrary)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            
        }))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func selectImage(sourceType: UIImagePickerController.SourceType) {
        imagePicker.modalPresentationStyle = .fullScreen
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.mediaTypes = [kUTTypeImage as String]
        imagePicker.modalPresentationStyle = .fullScreen
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func isFormValid() -> Bool{
        if let franchiseName = self.txtFranchiseName.text, franchiseName.trimmedString().isEmpty {
            self.showAlertWithMessage(msg: "Please Enter Franchise Name")
            return false
        }
        if let minimumDeposit = self.txtMinimumDeposit.text, minimumDeposit.trimmedString().isEmpty {
            self.showAlertWithMessage(msg: "Please Enter Minimum Deposit")
            return false
        }
        return true
    }
    
    @IBAction func btnSubmitAction(_ sender: Any) {
        
        if self.isFormValid() {
            if self.locationImage == nil {
                
                self.arrSelectedCategory.removeAll()
                
                for i in 0 ..< self.arrAppData.count {
                    if self.arrAppData[i].name == self.txtFranchiseCategory.selectedItem {
                        self.arrSelectedCategory.append(self.arrAppData[i].id ?? "")
                        break
                    }
                }
                
                var parameters = [String: Any]()
                parameters = [
                    "accountId": self.account.id!,
                    "franchiseName": self.txtFranchiseName.text!,
                    "minimumDeposit": self.txtMinimumDeposit.text!,
                    "franchiseCategories": self.arrSelectedCategory
                ]
                if isFromEditProfile {
                    self.franchisorUpdate(parameters: parameters)
                } else {
                    self.callFranchiseSignup(parameters: parameters)
                }
                
            } else {
                self.uploadImageToFirebase()
            }
            
        } else {
            self.showAlertWithMessage(msg: "Please enter all details.")
        }
    }
    
    func uploadImageToFirebase() {
        let storageRef = Storage.storage().reference().child("USER_\(self.account.id ?? "").png")
        if let uploadData = self.imgLocation.image?.pngData(){
            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    print("error")
                } else {
                    storageRef.downloadURL(completion: { (url, error) in
                        print("Image URL: \((url?.absoluteString)!)")
                        self.account.picture = url?.absoluteString
                        
                        self.arrSelectedCategory.removeAll()
                        
                        for i in 0 ..< self.arrAppData.count {
                            if self.arrAppData[i].name == self.txtFranchiseCategory.selectedItem {
                                self.arrSelectedCategory.append(self.arrAppData[i].id ?? "")
                            }
                        }
                        
                        
                        var parameters = [String: Any]()
                        parameters = [
                            "accountId": self.account.id!,
                            "franchiseName": self.txtFranchiseName.text!,
                            "minimumDeposit": self.txtMinimumDeposit.text!,
                            "franchiseCategories": self.arrSelectedCategory,
                            "picture": self.account.picture ?? url!.absoluteString,
                            "countryCode": self.account.franchise?.countryCode! ?? "+" ,
                            "phoneNumber": self.account.franchise?.phoneNumber! ?? ""
                            
                        ]
                        
                        print(parameters)
                        
                        if self.isFromEditProfile {
                            self.franchisorUpdate(parameters: parameters)
                        } else {
                            self.callFranchiseSignup(parameters: parameters)
                        }
                    })
                }
            })
        }
    }
}

extension PVFranchisorsSignupVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.locationImage = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage)!
        self.imgLocation.image = locationImage
        picker.dismiss(animated: true, completion: nil)
    }
}
