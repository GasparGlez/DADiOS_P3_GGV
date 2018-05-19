//
//  TwoFactorAuthenticationViewController.swift
//  PR3
//
//  Copyright © 2018 UOC. All rights reserved.
//

import UIKit

class AuthenticationViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var firstField: UITextField!
    @IBOutlet weak var secondField: UITextField!
    @IBOutlet weak var thirdField: UITextField!
    @IBOutlet weak var fourthField: UITextField!
    
    // BEGIN UOC3 - Outlets
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var fourthLabel: UILabel!
    @IBOutlet weak var upperLabelConstraint: NSLayoutConstraint!
    @IBOutlet weak var backButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var nextButtonConstraint: NSLayoutConstraint!
    // END UOC3 - Outlets
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // We first check that the user is only entering numeric characters
        let numericSet = CharacterSet.decimalDigits
        let stringSet = CharacterSet(charactersIn: string)
        let onlyNumeric = numericSet.isSuperset(of: stringSet)
        
        if !onlyNumeric {
            return false
        }
        
        // We then check that the length of resulting text will be smaller or equal to 1
        let currentString = textField.text ?? ""
        
        guard let stringRange = Range(range, in: currentString) else {
            return false
        }
        
        let resultingString = currentString.replacingCharacters(in: stringRange, with: string)
        
        let resultingLength = resultingString.count
        
        if resultingLength <= 1 {
            return true
        } else {
            return false
        }
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        doAuthentication()
    }
    
    // BEGIN-UOC-2
    // Initial focus on firstField to start entering the 4 digit code
    // viewDidLoad() is the first method to be called when view controller loads
    override func viewDidLoad() {
        super.viewDidLoad()
        firstField.becomeFirstResponder()
    }
    
    // Event Editing Changed for every UITextField to go to next field when user fills every valur
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        
        switch sender {
        case firstField:
            secondField.becomeFirstResponder()
        case secondField:
            thirdField.becomeFirstResponder()
        case thirdField:
            fourthField.becomeFirstResponder()
        case fourthField:
            fourthField.resignFirstResponder()
            // Call to authentication function like "Next" button
            doAuthentication()
        default:
            sender.resignFirstResponder()
        }
    }
    // END-UOC-2
    
    func doAuthentication() {
        var validCode: Bool
        if let firstCode = firstField.text, let secondCode = secondField.text, let thirdCode = thirdField.text, let fourthCode = fourthField.text {
            let fullCode = firstCode + secondCode + thirdCode + fourthCode
            validCode = Services.validate(code: fullCode)
        } else {
            validCode = false
        }
        
        if validCode {
            // BEGIN-UOC-3
            // One second animation
            UIView.animate(withDuration: 1,
                           delay: 0,
                           options: [],
                           animations: {
                            self.updateAlphaViews()
                            self.updateLabelConstraints()
                            self.view.layoutIfNeeded()
                            })
            // Perform segue after animation
            performSegue (withIdentifier: "SegueToMainNavigation", sender: self)
            // END-UOC-3
        } else {
            let errorMessage = "Sorry, the entered code is not valid"
            let errorTitle = "We could not autenticate you"
            Utils.show (Message: errorMessage, WithTitle: errorTitle, InViewController: self)
        }
    }
    
    // BEGIN - Animation functions UOC-3
    // Update constraints to animate "movement" of buttons & upper label
    func updateLabelConstraints() {
        let screenWidth = view.frame.width
        let screenHeight = view.frame.height
        backButtonConstraint.constant = +screenWidth
        nextButtonConstraint.constant = -screenWidth
        upperLabelConstraint.constant = -screenHeight
    }
    // Update alpha for labels & fields
    func updateAlphaViews() {
        firstField.alpha = 0
        secondField.alpha = 0
        thirdField.alpha = 0
        fourthField.alpha = 0
        firstLabel.alpha = 0
        secondLabel.alpha = 0
        thirdLabel.alpha = 0
        fourthLabel.alpha = 0
    }
    // END - Animation functions UOC-3
}
