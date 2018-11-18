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
    
    var key =  String()
    
    var userID = Auth.auth().currentUser?.uid
    
    var ref: DatabaseReference!
    private var databaseHandle: DatabaseHandle!

    
    
    @IBOutlet weak var surveyName: UITextField!
    
    private(set) var setLabel: String = "" {
        didSet {
            surveyName.text = setLabel
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
        self.loadFromFireBase()
        
    }
    
    func loadFromFireBase(){

        ref.child("Surveys//\(userID!)/\(key)").observe(.value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let surveyTitle = value?["title"] as? String ?? ""
            self.setLabel = surveyTitle
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }

    
    
    @IBAction func createSurvey(_sender: Any) {
       // let authorRef = self.ref!.child(userID!);

        //ref?.child("surveys").childByAutoId().setValue(["title": "surveyNameView",
                                                        //"author": userID!])
       // authorRef.setValue(["title": surveyName.text!])

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
