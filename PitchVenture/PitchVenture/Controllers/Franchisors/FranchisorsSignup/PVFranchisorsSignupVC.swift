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

class PVFranchisorsSignupVC: PVBaseVC {

    @IBOutlet weak var txtFranchiseName: UITextField!
    
    @IBOutlet weak var txtMinimumDeposit: UITextField!
    
    @IBOutlet weak var txtFranchiseCategory: IQDropDownTextField!
    
    @IBOutlet weak var btnImagePicker: UIButton!
    @IBOutlet weak var imgLocation: UIImageView!
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
        self.setNavigationTitle("Add Franchise Details")
        self.getAppData()
    }
    // MARK: - Class Methods
    
    class func instantiate() -> PVLoginVC {
        return UIStoryboard.main().instantiateViewController(withIdentifier: PVLoginVC.identifier()) as! PVLoginVC
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
            self.showAlertWithMessage(msg: "Please Enter Apartment No")
            return false
        }
        if let minimumDeposit = self.txtMinimumDeposit.text, minimumDeposit.trimmedString().isEmpty {
            self.showAlertWithMessage(msg: "Please Enter Minimum Deposit")
            return false
        }
        if let franchiseCategory = self.txtFranchiseCategory.selectedItem?.trimmedString(), franchiseCategory.trimmedString().isEmpty {
            self.showAlertWithMessage(msg: "Please Enter Franchise Category")
            return false
        }
        return true
    }
    
    @IBAction func btnSubmitAction(_ sender: Any) {
        
        var parameters = [String: Any]()
        parameters = [
            "accountId": self.account.id!,
            "minimumDeposit": self.txtMinimumDeposit.text!,
            "franchiseCategories": self.txtFranchiseCategory.selectedItem?.trimmedString()
        ]
        
        if self.isFormValid() {
            self.callFranchiseSignup(parameters: parameters)
        } else {
            self.showAlertWithMessage(msg: "Please enter all details.")
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

