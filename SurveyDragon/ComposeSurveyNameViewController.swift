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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("survey name view is shown")
        
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addSurvey(_ sender: Any) {
        let user = Auth.auth().currentUser
        let surveyName = surveyNameTextView.text
        
        ref?.child("Surveys").childByAutoId().setValue([
            "title": surveyName,
            "user": user!.uid ]) {
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print("Data could not be saved: \(error). :(")
            } else {
                print("Data saved successfully!")
            }
        }
        
        print("just added survey: ", surveyName!)
        
        self.performSegue(withIdentifier: "goToSurveyQuestionCreation", sender: self)
        
        
        // submit the name of the survey
        
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
