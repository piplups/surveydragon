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
    var key: String?
    var userID = Auth.auth().currentUser?.uid
    
    @IBOutlet weak var QuestionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addLongQuestion(_ sender: Any) {
        print("Was here \(key!)")
        // Post the data to Firebase
        
        //get the key
        let questionText = QuestionTextField.text

        


        let questionDetails = [
            "type": "longAnswer",
            "question": questionText
            ]
        
        // add the keys under Questions
        ref?.child("Surveys/\(key!)").setValue(questionDetails)
        

        
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
