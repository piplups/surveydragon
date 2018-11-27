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

class MySurveyResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var surveys = ["How is your semester going?", "Are you stressed?", "Excited for winter break?",
                   "Computer Science?", "milk or cereal first?", "what time you wake up?",
                   "do you like mac n cheese", "this project needs to work"]
    
    var key: String?
    var userID = Auth.auth().currentUser?.uid
    
    var ref: DatabaseReference!
    
    
    @IBOutlet weak var mySurveyTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()

        mySurveyTableView.dataSource = self
        mySurveyTableView.delegate = self
        
        // TODO: make function to pull from database
        
        // Do any additional setup after loading the view.
        self.loadFromFireBase()

        self.mySurveyTableView.reloadData()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return surveys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // TODO:
        cell.textLabel?.text = surveys[indexPath.row]
        return cell

    }
    
    func loadFromFireBase(){
        
        ref.child("Authors/\(userID!)").observe(.value, with: { (snapshot) in

            self.surveys.removeAll()
            for user_child in (snapshot.children) {
                let user_snap = user_child as! DataSnapshot
                let dict = user_snap.value as! [String: String?]
                var question = dict["title"] as? String
                self.surveys.append(question!)
                self.mySurveyTableView.reloadData()
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
