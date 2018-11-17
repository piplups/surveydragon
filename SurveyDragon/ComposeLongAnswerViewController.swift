//
//  ComposeLongAnswerViewController.swift
//  SurveyDragon
//
//  Created by Philip Nguyen on 11/16/18.
//  Copyright © 2018 Philip Nguyen. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ComposeLongAnswerViewController: UIViewController {

    var ref: DatabaseReference?
    
    @IBOutlet weak var QuestionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addLongQuestion(_ sender: Any) {
        let user = Auth.auth().currentUser
        // Post the data to Firebase
        ref?.child("Questions").childByAutoId().setValue([
            "type": "longAnswer",
            "user": user!.uid,
            "question": QuestionTextField.text
            ])
        // Dismiss the popover
        // using presentingViewController
        presentingViewController?.dismiss(animated: true, completion: nil)
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
