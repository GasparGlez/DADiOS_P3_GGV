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
        
        // GGV Set values to outlets
        nameField.text = currentProfile?.name
        surnameField.text = currentProfile?.surname
        streetAddressField.text = currentProfile?.streetAddress
        cityField.text = currentProfile?.city
        occupationField.text = currentProfile?.occupation
        companyField.text = currentProfile?.company
        incomeField.text = String(currentProfile?.income ?? 0)

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
    
    // Function to check if a string is a valid int to validate income field value
    func isStringAnInt(string: String) -> Bool {
        return Int(string) != nil
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
            
        // Check incomeField textField has a valid format amount (example: [-]XXXX,YY)
        case incomeField:
            let validIncomeFieldStringEntered = isStringAnInt(string: string) || string == ""
            // Return true if user entered a number character or delete key (string == "")
            return validIncomeFieldStringEntered
        default:
            return true
        }
    }
    
    // XPP-BEGIN - Button "Done" for number pad
    // -------------------- ¡¡ Thanks for the code Xavier :) !! --------------------
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
    // XPP-END - Button "Done" for number pad
    // END-UOC-4
    
    
    // BEGIN-UOC-5
    @IBAction func takePicture(_ sender: AnyObject) {
        
        let imagePicker = UIImagePickerController()
        // If the device has a camera (not in simulator), take a picture, else, pick it from the photo library
        // Added NSCameraUsageDescription and NSPhotoLibraryAddUsageDescription keys in Info.plist file with the reasons for requesting access to camera and photo library respectively
        
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
        
        // Save profile image
        saveProfileImage(image)
        
        }
    // END-UOC-5
    
    // BEGIN-UOC-6
    // Function to locate the user's documents directory where we can save app files
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    // Load image from filesystem
    func loadProfileImage() -> UIImage? {
        
        // Declare image location
        let imagePath = getDocumentsDirectory().appendingPathComponent("profile_image.png").path
        let imageUrl: URL = URL(fileURLWithPath: imagePath)
        
        // Check if the image is stored already. If don't, load "EmptyProfile.png"
        if FileManager.default.fileExists(atPath: imagePath),
            let imageData: Data = try? Data(contentsOf: imageUrl),
            let image: UIImage = UIImage(data: imageData, scale: UIScreen.main.scale) {
            return image
        }
        else {
            return UIImage(named: "EmptyProfile.png")
        }
    }
    
    // Save image using UIImagePNGRepresentation
    func saveProfileImage(_ image: UIImage) {
        if let data = UIImagePNGRepresentation(image) {
            let filename = getDocumentsDirectory().appendingPathComponent("profile_image.png")
            try? data.write(to: filename)
        }
    }
    // END-UOC-6
    
    // BEGIN-UOC-7
    // Construct URL to the profile file
    let profileArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("profile.archive")
    }()
    
    @IBAction func saveProfile(_ sender: Any) {
        // Profile values from outlets
        let profile = Profile(name: nameField.text ?? "", surname: surnameField.text ?? "", streetAddress: streetAddressField.text ?? "", city: cityField.text ?? "", occupation: occupationField.text ?? "", company: companyField.text ?? "", income: Int(incomeField.text ?? "0") ?? 0)
        // Save profile
        saveProfileData(profile)
        Utils.show(Message: "Saved succesfully", WithTitle: "Profile Information", InViewController: self)
    }
    
    func saveProfileData(_ currentProfile: Profile) {
        NSKeyedArchiver.archiveRootObject(currentProfile, toFile: profileArchiveURL.path)
    }
    
    func loadProfileData() -> Profile {
        // Return the saved profile or a empty profile if there is not a saved profile
        if let savedProfile = NSKeyedUnarchiver.unarchiveObject(withFile: profileArchiveURL.path) as? Profile {
            return savedProfile
        }
        else {
            return Profile()
        }
    }
    // END-UOC-7
}
