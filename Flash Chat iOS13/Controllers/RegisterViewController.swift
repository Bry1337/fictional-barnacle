//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Bryan on 21/10/2023.
//  Copyright © 2023 Bryan Abergas. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    var error: String?
    
    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    self.error = e.localizedDescription
                    print(e.localizedDescription)
                } else {
                    self.error = nil
                    self.performSegue(withIdentifier: Constants.registerSegue, sender: self)
                }
            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard identifier == Constants.registerSegue && error == nil else {
            return false
        }
        return false
    }
}
