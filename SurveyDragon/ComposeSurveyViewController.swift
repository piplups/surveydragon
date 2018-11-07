//
//  ComposeSurveyViewController.swift
//  SurveyDragon
//
//  Created by Philip Nguyen on 11/5/18.
//  Copyright © 2018 Philip Nguyen. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ComposeSurveyViewController: UIViewController {
    
    
    
    let userID = Auth.auth().currentUser?.uid
    
    var ref: DatabaseReference?
    
    @IBOutlet weak var surveyNameView: UITextView!
    // should detect changes from this UITextView
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func createSurvey(_sender: Any) {
        ref?.child("surveys").childByAutoId().setValue(["title": surveyNameView,
                                                        "author": userID!])
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func appendQuestion(_sender: Any) {
        
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
