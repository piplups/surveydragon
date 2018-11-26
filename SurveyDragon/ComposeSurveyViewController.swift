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

class ComposeSurveyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    var key: String?
    var userID = Auth.auth().currentUser?.uid
    var numberOfQuestion:String = ""
    
    var ref: DatabaseReference!
    
    // var questions = [String]() // this is for the table view. Used to store the list of questions.
    let questions = ["How is your semester going?", "Are you stressed?", "Excited for winter break?",
                     "Computer Science?", "milk or cereal first?", "what time you wake up?",
                     "do you like mac n cheese", "this project needs to work"]
    
    @IBOutlet weak var surveyName: UITextField!
    
    @IBOutlet weak var questionTableView: UITableView!
    
    private(set) var setLabel: String = "" {
        didSet {
            surveyName.text = setLabel
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // TODO:
        cell.textLabel?.text = questions[indexPath.row]
        //cell.textLabel.text = questions[indexPath.row]
        
        return cell
    }
    
    func loadQuestions() {
        
        // TODO: pull questions from the current user's current survey from database
        ref = Database.database().reference()
        //ref.child("Surveys").queryOrderedByKey() // don't know how exactly this will
        self.questionTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
        // taken out for testing
        
        // self.loadFromFireBase()
        questionTableView.dataSource = self
        questionTableView.delegate = self
        
        self.loadQuestions()
    }
    
    func loadFromFireBase(){

        ref.child("Surveys/\(key!)").observe(.value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let surveyTitle = value?["title"] as? String ?? ""
            self.numberOfQuestion = value?["numOfQuestions"] as? String ?? ""
            self.setLabel = surveyTitle
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newLongAnswer" {
            let composeLongAnswerViewController = segue.destination as! ComposeLongAnswerViewController
            composeLongAnswerViewController.key = key!
            composeLongAnswerViewController.numOfQuestions = self.numberOfQuestion
            print("num: \(numberOfQuestion)")
        }
        if segue.identifier == "newMultiChoice" {
            let composeMultipleChoiceViewController = segue.destination as! ComposeMultipleChoiceViewController
            composeMultipleChoiceViewController.key = key!
            composeMultipleChoiceViewController.numOfQuestions = self.numberOfQuestion
            print("num: \(numberOfQuestion)")
        }
        //composeSurveyViewController.userID = user
    }
    
    
    @IBAction func createSurvey(_sender: Any) {
       // let authorRef = self.ref!.child(userID!);

        //ref?.child("surveys").childByAutoId().setValue(["title": "surveyNameView",
                                                        //"author": userID!])
       // authorRef.setValue(["title": surveyName.text!])

        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    /*
    @IBAction func appendQuestion(_sender: Any) {
        
    }
    */
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
