//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Bryan on 21/10/2023.
//  Copyright © 2023 Bryan Abergas. All rights reserved.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        titleLabel.text = Constants.appName
        
        // Native demo of animation
//        let titleText = "⚡️FlashChat"
//        var charIndex = 0.0
//        titleLabel.text = ""
//        for letter in titleText {
//            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) {
//                (timer) in self.titleLabel.text?.append(letter)
//            }
//            charIndex += 1
//        }
       
    }
    
    @IBAction func navigationPressed(_ sender: UIButton) {
    }
    
}
