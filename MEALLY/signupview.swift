//
//  signupview.swift
//  Meally
//
//  Created by Brwerx on 8/16/24.
//

import Foundation
import UIKit

class SignUpViewController: UIViewController {
    let accountService = AccountService()
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        let username = "testuser"  // Replace with actual user input
        let password = "password"  // Replace with actual user input
        
        accountService.registerAccount(username: username, password: password) { result in
            switch result {
            case .success(let response):
                print("Registration successful: \(response)")
                // Update UI or navigate to another screen
            case .failure(let error):
                print("Registration error: \(error)")
                // Show error to the user
            }
        }
    }
}
