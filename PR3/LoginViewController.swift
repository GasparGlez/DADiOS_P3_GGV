//
//  LoginViewController.swift
//  PR3
//
//  Copyright © 2018 UOC. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var welcomeLabel: UILabel!

    @IBAction func loginTapped(_ sender: UIButton) {
        if let username = usernameField.text, let password = passwordField.text {
            let canLogin = Services.validate(username: username, password: password)
            
            if canLogin {
                performSegue(withIdentifier: "SegueToAuthentication", sender: self)
            } else {
                let errorMessage = "Sorry, the username and password are invalid"
                let errorTitle = "We could not log you in"
                
                Utils.show(Message: errorMessage, WithTitle: errorTitle, InViewController: self)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        usernameField.text = ""
        passwordField.text = ""
    }
    
    override func viewDidLoad() {
        let hour = Calendar.current.component(.hour, from: Date())
        
        var colorOfTheHour:UIColor
        var messageOfTheHour:String
        
        switch hour {
        case 5...11:
            colorOfTheHour = UIColor.orange.lighter()
            messageOfTheHour = "Good morning"
        case 12...17:
            colorOfTheHour = UIColor.yellow.lighter()
            messageOfTheHour = "Good afternoon"
        case 18...21:
            colorOfTheHour = UIColor.red.lighter()
            messageOfTheHour = "Good evening"
        case 22...23:
            colorOfTheHour = UIColor.blue.lighter()
            messageOfTheHour = "Good night"
        case 0...1:
            colorOfTheHour = UIColor.blue.lighter()
            messageOfTheHour = "Good night"
        default:
            colorOfTheHour = UIColor.white
            messageOfTheHour = "Welcome"
        }
        
        self.view.backgroundColor = colorOfTheHour
        self.welcomeLabel.text = messageOfTheHour
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func unwindToLogin(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        print("Unwind to login")
    }
    
    // BEGIN-UOC-1
    
    // END-UOC-1
}
