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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setLeftBarButton()
        self.setNavigationTitle("Add Store Details")
    }
    // MARK: - Class Methods
    
    class func instantiate() -> PVInputLocationVC {
        return UIStoryboard.main().instantiateViewController(withIdentifier: PVInputLocationVC.identifier()) as! PVInputLocationVC
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
//        let user = User(id: nil, fullName: "Demo user", phoneNumber: nil, deviceInfo: nil, appInfo: nil, profilePicture: nil, gender: nil, address: nil, dob: nil, accessToken: nil, pushToken: nil)
//        PVUserManager.sharedManager().activeUser = user
//        let sceneD = SceneDelegate()
//        sceneD.setRootController()
//
//        appDel.setRootViewController()
        
        let objPVInputLocationVC = PVStoreOwnerHomeVC.instantiate()
        self.push(vc: objPVInputLocationVC)
    }
    
    
    func isFormValid() -> Bool{
        if let apartmentNo = self.txtApartmentNo.text, apartmentNo.trimmedString().isEmpty {
            return false
        }
        if let addressLine1 = self.txtAddressLine1.text, addressLine1.trimmedString().isEmpty {
            return false
        }
        if let addressLine1 = self.txtAddressLine1.text, addressLine1.trimmedString().isEmpty {
            return false
        }
        if let addressLine1 = self.txtAddressLine1.text, addressLine1.trimmedString().isEmpty {
            return false
        }
        if let addressLine1 = self.txtAddressLine1.text, addressLine1.trimmedString().isEmpty {
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
}
