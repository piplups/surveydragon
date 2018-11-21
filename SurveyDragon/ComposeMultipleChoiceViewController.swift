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
        // TODO: add question and answer choices to DB
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
