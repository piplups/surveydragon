//
//  MySurveyResultsViewController.swift
//  SurveyDragon
//
//  Created by Philip Nguyen on 11/26/18.
//  Copyright © 2018 Philip Nguyen. All rights reserved.
//

import UIKit

class MySurveyResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var surveys = [String]()
    
    @IBOutlet weak var mySurveysTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO: make function to pull from database
        
        // Do any additional setup after loading the view.
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
        // let indexPath = mySurveysTableView.indexPathForSelectedRow
        
        // TODO: pass data to the Results page!
        let singleSurveyResultsViewController = segue.destination as! SingleSurveyResultsViewController
        singleSurveyResultsViewController.data = "data"
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
