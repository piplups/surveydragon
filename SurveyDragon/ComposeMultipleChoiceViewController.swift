//
//  ComposeMultipleChoiceViewController.swift
//  SurveyDragon
//
//  Created by Philip Nguyen on 11/21/18.
//  Copyright © 2018 Philip Nguyen. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ComposeMultipleChoiceViewController: UIViewController {

    var ref: DatabaseReference?
    var key: String?
    var userID = Auth.auth().currentUser?.uid
    var numOfQuestions:String=""
    
    @IBOutlet weak var QuestionTextField: UITextField!
    @IBOutlet weak var Answer1TextField: UITextField!
    @IBOutlet weak var Answer2TextField: UITextField!
    @IBOutlet weak var Answer3TextField: UITextField!
    @IBOutlet weak var Answer4TextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addQuestion(_ sender: Any) {
        print("WAS HERE");

        // TODO: add question and answer choices to DB
        let questionText = QuestionTextField.text
        let answer1Text = Answer1TextField.text
        let answer2Text = Answer2TextField.text
        let answer3Text = Answer3TextField.text
        let answer4Text = Answer4TextField.text

        
        //var questionNum:Int
        let questionDetails = [
            "type": "multipleChoice",
            "question": questionText,
            "answer1": answer1Text,
            "count1": "0",
            "answer2": answer2Text,
            "count2": "0",
            "answer3": answer3Text,
            "count3": "0",
            "answer4": answer4Text,
            "count4": "0"
        ]
        var num = Int(numOfQuestions)
        num = num! + 1
        numOfQuestions = String(num!)
        
        
        
        // add the keys under Questions
        ref?.child("Surveys/\(key!)").updateChildValues(["numOfQuestions":numOfQuestions])
        ref?.child("Surveys/\(key!)/Questions/\(numOfQuestions)").setValue(questionDetails)
        
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
