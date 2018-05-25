//
//  ProfileViewController.swift
//  PR3
//
//  Copyright © 2018 UOC. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
   
    var currentProfile: Profile?
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var surnameField: UITextField!
    @IBOutlet weak var streetAddressField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var occupationField: UITextField!
    @IBOutlet weak var companyField: UITextField!
    @IBOutlet weak var incomeField: UITextField!
    
    override func viewDidLoad() {
        profileImage.image = loadProfileImage()
        
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true
        
        currentProfile = loadProfileData()
        
        // GGV nameField first position field
        nameField.becomeFirstResponder()
        
        // GGV Code to dismiss keyborad
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    // GGV Dismiss keyboard
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // BEGIN-UOC-4
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameField:
            surnameField.becomeFirstResponder()
        case surnameField:
            streetAddressField.becomeFirstResponder()
        case streetAddressField:
            cityField.becomeFirstResponder()
        case cityField:
            occupationField.becomeFirstResponder()
        case occupationField:
            companyField.becomeFirstResponder()
        case companyField:
            incomeField.becomeFirstResponder()
        case incomeField:
            incomeField.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
            
        // Check incomeField textField has a valid format amount (example: [-]XXXX,YY)
        case incomeField:

            let textFieldContent = textField.text ?? ""
            // If It's the first character and It's a "-" then is a "valid" number part
            if  (textFieldContent == "" && string=="-") { return true }
            // Else
            else {
                // If we have a character typed (not a first "-"). Concatenate and check
                if (textFieldContent != "" || string != "") {
                    let resultString = textFieldContent + string
                    return resultString.isValidIncome(maxDecimalPlaces: 2)
                }
                // Else (no content)
                return true
            }
        default:
            return true
        }
    }
    
    //XPP-BEGIN - Button "Done" for number pad
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if (textField == incomeField) {
            let numberToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
            numberToolbar.barStyle = .default
            let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let button = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneWithNumberPad))
            numberToolbar.items = [spacer, button]
            numberToolbar.sizeToFit()
            incomeField.inputAccessoryView = numberToolbar
        }
    }
    
    @objc func doneWithNumberPad(sender: UIBarButtonItem) {
        incomeField.resignFirstResponder()
    }
    
    //XPP-END
    
    // END-UOC-4
    
    
    // BEGIN-UOC-5
    
    
    @IBAction func takePicture(_ sender: AnyObject) {
        
        let imagePicker = UIImagePickerController()
        
        // If the device has a camera (not in simulator), take a picture, else, pick from photo library
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        
        imagePicker.delegate = self
        
        // Place image picker on the screen
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // Get picked image from info dictionary
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage

        // Image to screen with view scaling (aspect fit)
        profileImage.contentMode = .scaleAspectFit
        profileImage.image = image
        
        
        // Take image picker off the screen - you must call this dismiss method
        dismiss(animated: true, completion: nil)
        
        //saveProfileImage(image)
        
        }
    // END-UOC-5
    
    // BEGIN-UOC-6
    func loadProfileImage() -> UIImage? {
        return UIImage(named: "EmptyProfile.png")
    }
    
    func saveProfileImage(_ image: UIImage) {
        
    }
    // END-UOC-6
    
    // BEGIN-UOC-7
    func saveProfileData(_ currentProfile: Profile) {
        
    }
    
    func loadProfileData() -> Profile {
        let profile = Profile(name: "Sherlock", surname: "Holmes", streetAddress: "221B Baker Street", city: "London", occupation: "Detective", company: "Self-employed", income: 500)
        return profile
    }
    // END-UOC-7
}
