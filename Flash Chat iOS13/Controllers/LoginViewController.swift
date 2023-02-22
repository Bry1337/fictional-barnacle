//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Bryan on 21/10/2023.
//  Copyright © 2023 Bryan Abergas. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    var error: String?

    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    self.error = e.localizedDescription
                    print(e.localizedDescription)
                } else {
                    self.error = nil
                    self.performSegue(withIdentifier: Constants.loginSegue, sender: self)
                }
            }
        }
    }
    
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard identifier == Constants.loginSegue && error == nil else {
            return false
        }
        return false
    }
    
}
