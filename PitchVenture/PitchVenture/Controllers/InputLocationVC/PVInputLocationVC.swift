//
//  PVInputLocationVC.swift
//  PitchVenture
//
//  Created by Daksh Upadhyay on 2021-11-19.
//  Copyright © 2021 PitchVenture. All rights reserved.
//

import UIKit
import AVKit
import MobileCoreServices
import Firebase
import FirebaseStorage
import SDWebImage

class PVInputLocationVC: PVBaseVC {

    //MARK: - Outlets
    @IBOutlet weak var btnImagePicker: UIButton!
    @IBOutlet weak var imgLocation: UIImageView!
    @IBOutlet weak var txtApartmentNo: UITextField!
    @IBOutlet weak var txtAddressLine1: UITextField!
    @IBOutlet weak var txtAddressLine2: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtProvince: UITextField!
    @IBOutlet weak var txtPostalCode: UITextField!
    @IBOutlet weak var btnSubmit: PVButton!
    var imagePicker = UIImagePickerController()
    
    var locationImage: UIImage?
    
    var account : Account = Account()
    
    var isFromEditProfile: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.isFromEditProfile {
            self.setNavigationTitle("Edit Store")
            self.autoFillData()
        } else {
            self.setNavigationTitle("Add Store Details")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setLeftBarButton()
        PVUserManager.sharedManager().loadActiveUser()
    }
    // MARK: - Class Methods
    
    class func instantiate() -> PVInputLocationVC {
        return UIStoryboard.main().instantiateViewController(withIdentifier: PVInputLocationVC.identifier()) as! PVInputLocationVC
    }
    
    func autoFillData() {
        
        self.txtApartmentNo.text = self.account.storeOwner?.apartmentNumber
        self.txtAddressLine1.text = self.account.storeOwner?.addressLine1
        self.txtAddressLine2.text = self.account.storeOwner?.addressLine2
        self.txtCity.text = self.account.storeOwner?.city
        self.txtProvince.text = self.account.storeOwner?.province
        self.txtPostalCode.text = self.account.storeOwner?.postalCode
        
        self.imgLocation.sd_setImage(with: URL(string: self.account.storeOwner?.pictures?[0] ?? ""), placeholderImage: UIImage(named: "ic_logo.png"))
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
    
    @IBAction func btnSubmitAction(_ sender: Any) {
        
        if self.isFormValid() {
            //UPLOAD IMAGE TO FIREBASE AND GET IMAGE URL
            self.uploadImageToFirebase()
        } else {
            self.showAlertWithMessage(msg: "Please enter all details.")
        }
    }
    
    
    func isFormValid() -> Bool{
        if let apartmentNo = self.txtApartmentNo.text, apartmentNo.trimmedString().isEmpty {
            self.showAlertWithMessage(msg: "Please Enter Apartment No")
            return false
        }
        if let addressLine1 = self.txtAddressLine1.text, addressLine1.trimmedString().isEmpty {
            self.showAlertWithMessage(msg: "Please Enter Address Line 1")
            return false
        }
        if let city = self.txtCity.text, city.trimmedString().isEmpty {
            self.showAlertWithMessage(msg: "Please Enter City")
            return false
        }
        if let province = self.txtProvince.text, province.trimmedString().isEmpty {
            self.showAlertWithMessage(msg: "Please Enter Province")
            return false
        }
        
        if let postalCode = self.txtPostalCode.text, postalCode.trimmedString().isEmpty {
            self.showAlertWithMessage(msg: "Please Enter Postal Code")
            return false
        }
        return true
    }
        
}

extension PVInputLocationVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.locationImage = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage)!
        self.imgLocation.image = locationImage
        picker.dismiss(animated: true, completion: nil)
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
                        self.account.storeOwner?.pictures = []
                        self.account.storeOwner?.pictures?.append(url!.absoluteString)
                        
                        var parameters = [String: Any]()
                        parameters = [
                            "accountId": self.account.id!,
                            "apartmentNumber": self.txtApartmentNo.text!,
                            "addressLine1": self.txtAddressLine1.text!,
                            "addressLine2": self.txtAddressLine2.text!,
                            "city": self.txtCity.text!,
                            "province": self.txtProvince.text!,
                            "postalCode": self.txtPostalCode.text!,
                            "pictures": self.account.storeOwner?.pictures ?? url!.absoluteString,
                            "countryCode": self.account.storeOwner?.countryCode! ?? "+1",
                            "phoneNumber": self.account.storeOwner?.phoneNumber! ?? ""
                        ]
                        
                        print(parameters)
                        if self.isFromEditProfile {
                            self.storeOwenerUpdate(parameters: parameters)
                        } else {
                            self.callStoreOwnerSignup(parameters: parameters)
                        }
                        
                        
                    })
                }
            })
        }
    }
}
