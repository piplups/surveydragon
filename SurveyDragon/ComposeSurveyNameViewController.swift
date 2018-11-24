//
//  ComposeSurveyNameViewController.swift
//  SurveyDragon
//
//  Created by Philip Nguyen on 11/15/18.
//  Copyright © 2018 Philip Nguyen. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ComposeSurveyNameViewController: UIViewController {

    @IBOutlet weak var surveyNameTextView: UITextField!
    
    var ref: DatabaseReference?
    var key: String?
    let user = Auth.auth().currentUser

    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("survey name view is shown")
        
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addSurvey(_ sender: Any) {
        let surveyName = surveyNameTextView.text
        key = ref?.child("Authors/\(user!.uid)").childByAutoId().key
        
        //creating artist with the given values
        let survey = ["id":key,
                      "title": surveyName,
                      "numOfQuestions": "0"]
        
        //adding the artist inside the generated unique key
        ref?.child("Authors/\(user!.uid)").child(key!).setValue(["id":key, "title": surveyName])
        
        ref?.child("Surveys/\(key!)").setValue(survey)

        
        print("just added survey: ", surveyName!)
        
        self.performSegue(withIdentifier: "goToSurveyQuestionCreation", sender: self)
        
        
        // submit the name of the survey
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let composeSurveyViewController = segue.destination as! ComposeSurveyViewController
        composeSurveyViewController.key = key!
        //composeSurveyViewController.userID = user
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
