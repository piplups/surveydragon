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
    var numOfQuestions:String=""
    
    @IBOutlet weak var QuestionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addLongQuestion(_ sender: Any) {
        
        //get the key
        let questionText = QuestionTextField.text

        //var questionNum:Int


        let questionDetails = [
            "type": "longAnswer",
            "question": questionText
            ]
        var num = Int(numOfQuestions)
        num = num! + 1
        numOfQuestions = String(num!)
        
        

        // add the keys under Questions
        ref?.child("Surveys/\(key!)").updateChildValues(["numOfQuestions":numOfQuestions])
        ref?.child("Surveys/\(key!)/Questions/\(numOfQuestions)").setValue(questionDetails)
        

        
        // Dismiss the popover
        // using presentingViewController
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cancelQuestion(_ sender: Any) {
        // Dismiss the popover
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
