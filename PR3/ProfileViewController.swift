//
//  ProfileViewController.swift
//  PR3
//
//  Copyright © 2018 UOC. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController, UITextFieldDelegate {
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
        case incomeField:
            let incomeFieldText = incomeField.text ?? ""
            // User pressed the delete-key to remove a character, this is always valid, return true to allow change
            if incomeFieldText=="" { return true }
            
            // Build the full current string: TextField right now only contains the
            // previous valid value.
            // Can't just concat the two strings because the user might've moved the
            // cursor and delete something in the middle.
            let replacementText = (incomeFieldText as NSString).replacingCharacters(in: range, with: string)
            
            // Use new string extensions (Utils class) to check if the string is a valid income and only has the specified amount of decimal places.
            return replacementText.isValidIncome(maxDecimalPlaces: 2)
        default: return true
        }
    }
    
    // END-UOC-4
    
    
    // BEGIN-UOC-5
    //    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    //        saveProfileImage(image)
    //    }
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
