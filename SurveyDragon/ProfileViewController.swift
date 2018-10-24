//
//  ProfileViewController.swift
//  SurveyDragon
//
//  Created by Philip Nguyen on 10/21/18.
//  Copyright © 2018 Philip Nguyen. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    @IBOutlet weak var signOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func signOutUser(_ sender: Any) {
        
    }
    
    @IBAction func signOutButtonPressed(_ sender: Any) {
        
        
        // logout user
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out :%@", signOutError)
        }
        
        // transport user to login screen
        self.performSegue(withIdentifier: "goToLoginScreen", sender: self)
        print("User has been signed out")
    }
    

}

