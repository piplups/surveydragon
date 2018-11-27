//
//  FirstViewController.swift
//  SurveyDragon
//
//  Created by Philip Nguyen on 10/21/18.
//  Copyright © 2018 Philip Nguyen. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth


class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ref: DatabaseReference!
    var userID = Auth.auth().currentUser?.uid

    
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

        
        // Set the Firebase Reference
        ref = Database.database().reference()
        tableView.delegate = self
        tableView.dataSource = self
        self.loadSurvey()
        
        // Retreive the posts and listen for changes
        
        

    }
    
    func loadSurvey(){
        ref.child("Surveys").observe(.value, with: { (snapshot) in
        self.allSurveys.removeAll()

            for user_child in (snapshot.children) {
                let user_snap = user_child as! DataSnapshot
                let dict = user_snap.value as! [String: NSObject?]
                
                var title = dict["title"] as? String
                self.allSurveys.append(title!)
                self.tableView.reloadData()
            }
        
        })
        { (error) in
            print(error.localizedDescription)
        }
    }


}

