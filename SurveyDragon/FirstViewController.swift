//
//  FirstViewController.swift
//  SurveyDragon
//
//  Created by Philip Nguyen on 10/21/18.
//  Copyright © 2018 Philip Nguyen. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ref:DatabaseReference?
    var databaseHandle:DatabaseHandle?
    
    var allSurveys = [String]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allSurveys.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
        cell?.textLabel?.text = allSurveys[indexPath.row]
        
        return cell!
    }
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        
        // Set the Firebase Reference
        ref = Database.database().reference()
        
        // Retreive the posts and listen for changes
        databaseHandle = ref?.child("Surveys").observe(.childAdded, with: { (snapshot) in
            // code to execute when a child is added under "posts"
            // take the value from the snapshot and added it to the postData array
            let post = snapshot.value as? String
            
            if let actualPost = post {
                // Append the data to our postData array
                self.allSurveys.append(actualPost)
                // Reload the tableview
                self.tableView.reloadData()
            }
            
        })
    }


}

