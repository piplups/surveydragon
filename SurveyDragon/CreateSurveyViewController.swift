//
//  CreateSurveyViewController.swift
//  SurveyDragon
//
//  Created by Philip Nguyen on 11/16/18.
//  Copyright © 2018 Philip Nguyen. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CreateSurveyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Properties
    var key: String?
    var userID = Auth.auth().currentUser?.uid
    var numberOfSurveys: Int = 0
    
    var ref: DatabaseReference!
    
    // survey array to add to the table view
    var surveys = [String]()
    
    @IBOutlet weak var mySurveysTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return surveys.count
        // count of surveys created by this user
        // ref child ("Surveys) by user uid . count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCreatedSurveyCell", for: indexPath)
        
        // TODO:
        cell.textLabel?.text = surveys[indexPath.row]
        
        return cell
    }
    
    @IBOutlet weak var createSurveyButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
