//
//  ComposeViewController.swift
//  SurveyDragon
//
//  Created by Philip Nguyen on 10/22/18.
//  Copyright © 2018 Philip Nguyen. All rights reserved.
//

import UIKit
import FirebaseDatabase
import ResearchKit

class ComposeViewController: UIViewController {
    
    struct Question {
        var title: String
        var answers: [String]
        var type: String
    }
    
    
    @IBOutlet weak var surveyName: UILabel!
    var surveyID: String = ""
    var surveyTitle: String = ""
    var allQuestions = [Question]()

    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        self.loadFromFireBase()

        // Do any additional setup after loading the view.
    }
    
    // Take a survey functionality
    public var SurveyTask: ORKOrderedTask {
        var steps = [ORKStep]()

        var count = 1
        // for all questions in the survey
        for question in allQuestions {
            // if it's a long answer
            if question.type == "longAnswer" {
                let longAnswerFormat = ORKTextAnswerFormat(maximumLength: 30)
                longAnswerFormat.multipleLines = false
                let longQuestionStepTitle = question.title
                let longQuestionStep = ORKQuestionStep(identifier: String(count), title: longQuestionStepTitle, answer: longAnswerFormat)
                steps += [longQuestionStep]
                
            }
            
            // if it's a multiple choice question
            if question.type == "multipleChoice" {
                // Question title
                let multiChoiceQuestionStepTitle = question.title
                
                // Answer Choices
                var multiChoices = [ORKTextChoice]()
                var index = 0
                for choice in question.answers {
                    multiChoices.append(ORKTextChoice(text: choice, value: index as NSNumber))
                    index = index + 1
                }
                
                // Creating Multiple Choice question Object
                let multiChoiceAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: multiChoices)
                let multiChoiceQuestionStep = ORKQuestionStep(identifier: String(count), title: multiChoiceQuestionStepTitle, answer: multiChoiceAnswerFormat)
                steps += [multiChoiceQuestionStep]
            }
            count = count + 1
        }
        
        
        return ORKOrderedTask(identifier: "SurveyTask", steps: steps)
    }
    
    
    
    func loadFromFireBase(){
        ref.child("Surveys/\(surveyID)/Questions").observe(.value, with: { (snapshot) in
            
            //self.responses.removeAll()
            for user_child in (snapshot.children) {
                
                let user_snap = user_child as! DataSnapshot
                let dict = user_snap.value as! [String: String?]
                let question = dict["question"] as? String
                let type1 = dict["type"] as? String
                print ("type1 \(type1)")
                
                if type1 == "multipleChoice"{
                    let answer1 = dict["answer1"] as? String
                    let answer2 = dict["answer2"] as? String
                    let answer3 = dict["answer3"] as? String
                    let answer4 = dict["answer4"] as? String
                    let newQuestion = Question(title:question!, answers:[answer1!,answer2!,answer3!,answer4!],type: type1!)
                    self.allQuestions.append(newQuestion)
                }
                
                if type1 == "longAnswer"{
                    let newQuestion = Question(title:question!, answers:[],type: type1!)
                    self.allQuestions.append(newQuestion)

                }
                

            }
        })
        
    }

    
    @IBAction func consentTapped(sender : AnyObject) {
        let taskViewController = ORKTaskViewController(task: SurveyTask, taskRun: nil)
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
    }
    
    
    
    @IBAction func cancel(_ sender: Any) {
        // Dismiss the popover
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
extension ComposeViewController : ORKTaskViewControllerDelegate {
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        //Handle results with taskViewController.result
        taskViewController.dismiss(animated: true, completion: nil)
    }

}
