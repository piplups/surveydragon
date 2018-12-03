//
//  MySurveyResultsViewController.swift
//  SurveyDragon
//
//  Created by Philip Nguyen on 11/26/18.
//  Copyright © 2018 Philip Nguyen. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

// This view controller is used to VIEW surveys and their question RESULTS
class MySurveyResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var surveys = ["How is your semester going?", "Are you stressed?", "Excited for winter break?",
                   "Computer Science?", "milk or cereal first?", "what time you wake up?",
                   "do you like mac n cheese", "this project needs to work"]
    
    var surveyID = [String]()
    
    var key: String?
    var userID = Auth.auth().currentUser?.uid
    
    var ref: DatabaseReference!
    
    
    
    @IBOutlet weak var mySurveysTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()

        mySurveysTableView.dataSource = self
        mySurveysTableView.delegate = self
        
        // TODO: make function to pull from database
        
        // Do any additional setup after loading the view.
        self.loadFromFireBase()

        self.mySurveysTableView.reloadData()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return surveys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mySurveyCell", for: indexPath)
        
        //
        cell.textLabel?.text = surveys[indexPath.row]

        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // get index of the survey
         let indexPath = mySurveysTableView.indexPathForSelectedRow
        
        let singleSurveyResultsViewController = segue.destination as! SingleSurveyResultsViewController
        singleSurveyResultsViewController.surveyID = self.surveyID[indexPath!.row]
        singleSurveyResultsViewController.surveyTitle = self.surveys[indexPath!.row]

        
        // TODO: pass data to the Results page!
       // let singleSurveyResultsViewController = segue.destination as! SingleSurveyResultsViewController
       // singleSurveyResultsViewController.data = "data"

    }
    
    func loadFromFireBase(){
        
        ref.child("Authors/\(userID!)").observe(.value, with: { (snapshot) in

            self.surveys.removeAll()
            self.surveyID.removeAll()
            for user_child in (snapshot.children) {
                let user_snap = user_child as! DataSnapshot
                let dict = user_snap.value as! [String: String?]
                var title = dict["title"] as? String
                var surveyid = dict["id"] as? String

                self.surveyID.append(surveyid!)
                self.surveys.append(title!)
                self.mySurveysTableView.reloadData()
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
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
