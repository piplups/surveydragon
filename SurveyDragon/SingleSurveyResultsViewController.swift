//
//  SingleSurveyResultsViewController.swift
//  SurveyDragon
//
//  Created by Philip Nguyen on 11/26/18.
//  Copyright © 2018 Philip Nguyen. All rights reserved.
//

import UIKit

class SingleSurveyResultsViewController: UIViewController {

    // data pass into this string
    var data: String!
    
    // I created this UITextView to be uneditable
    // TODO: make this UITextView = data
    @IBOutlet weak var surveyResults: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
