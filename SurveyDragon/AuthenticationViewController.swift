//
//  AuthenticationViewController.swift
//  SurveyDragon
//
//  Created by Philip Nguyen on 10/23/18.
//  Copyright © 2018 Philip Nguyen. All rights reserved.
//

import UIKit
import FirebaseAuth

class AuthenticationViewController: UIViewController {

    @IBOutlet weak var signInSelector: UISegmentedControl!
    @IBOutlet weak var signInLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    var isSignIn: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInSelectorChanged(_ sender: UISegmentedControl) {
        
        // Flip the booleans
        isSignIn = !isSignIn
        
        // Check the bool and set the button and labels
        if isSignIn {
            signInLabel.text = "Sign In"
            signInButton.setTitle("Sign In", for: .normal)
        }
        else {
            signInLabel.text = "Register"
            signInButton.setTitle("Register", for: .normal)
        }
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        
        // TODO: Do some form validation on the email/password
        
        if let email = emailTextField.text, let pass = passwordTextField.text {
            // Check if it's sign in  or register
            if isSignIn {
                // SIGN IN the user with Firebase
                Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
                    // check if user isn't nil
                    if let u = user {
                        // user is found, go to home screen
                        self.performSegue(withIdentifier: "goToHome", sender: self)
                    } else {
                        // Error: check error and show message
                    }
                }
            } else {
                // REGISTER the user with Firebase
                Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
                    if let u = user {
                        // user is found, go to home screen
                        self.performSegue(withIdentifier: "goToHome", sender: self)
                    } else {
                        // Error: check error and show message
                    }
                }
            }
            
        }
        
        
        func touchesBegan(_ touches: Set<UITouch>, with: UIEvent?) {
            // Dismiss the keyboard when the view is tapped on
            emailTextField.resignFirstResponder()
            passwordTextField.resignFirstResponder()
        }
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
