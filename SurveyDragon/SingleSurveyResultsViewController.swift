//
//  SingleSurveyResultsViewController.swift
//  SurveyDragon
//
//  Created by Philip Nguyen on 11/26/18.
//  Copyright © 2018 Philip Nguyen. All rights reserved.
//

import UIKit
import Firebase


class SingleSurveyResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // TODO:
        cell.textLabel?.text = responses[indexPath.row]
        //cell.textLabel.text = questions[indexPath.row]
        
        return cell
    }
    

    // data pass into this string
    var data: String!
    var surveyID: String = ""
    var surveyTitle: String = ""
    var ref: DatabaseReference!
    var responses = [String]()

    
    @IBOutlet weak var surveyTitleLabel: UILabel!
    
    @IBOutlet weak var Results: UITableView!
    
    // I created this UITextView to be uneditable
    // TODO: make this UITextView = data
    @IBOutlet weak var surveyResults: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        Results.dataSource = self
        Results.delegate = self

        self.loadFromFireBase()
        surveyTitleLabel.text = self.surveyTitle

        // Do any additional setup after loading the view.
    }
    
    func loadFromFireBase(){
        ref.child("Surveys/\(surveyID)/Questions").observe(.value, with: { (snapshot) in
            
            self.responses.removeAll()
            var count = 1;
            for user_child in (snapshot.children) {
                let user_snap = user_child as! DataSnapshot
                let dict = user_snap.value as! [String: String?]
                var question = dict["question"] as? String
                var type = dict["type"] as? String
                question = String(count) + ". " + question!;
                count = count + 1
                self.responses.append(question!)

                if type == "multipleChoice" {
                    var answer1 = dict["answer1"] as? String
                    var answer2 = dict["answer2"] as? String
                    var answer3 = dict["answer3"] as? String
                    var answer4 = dict["answer4"] as? String

                    self.responses.append("a. " + answer1!)
                    self.responses.append("b. " + answer2!)
                    if answer3 != ""{
                        self.responses.append("c. " + answer3!)
                    }
                    if answer4 != ""{
                        self.responses.append("d. " + answer4!)
                    }
                }
                
                if type == "longAnswer" {

                }

                self.responses.append("")

                self.Results.reloadData()
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }

    @IBAction func backButton(_ sender: Any) {
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
