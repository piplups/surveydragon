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
        var answersCount: [String]
        var type: String
        var response:String
    }
    
    
    @IBOutlet weak var surveyName: UILabel!
    var surveyID: String = ""
    var surveyTitle: String = ""
    var allQuestions = [Question]()
    var numOfResponses: String = ""
    
    
    var ref2: DatabaseReference!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        self.loadFromFireBase()
        
        // Do any additional setup after loading the view.
    }
    
    // Take a survey functionality
    public var SurveyTask: ORKOrderedTask {
        //SurveyTask.identifier = "survey-task"
        
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
                
                if type1 == "multipleChoice"{
                    let answer1 = dict["answer1"] as? String
                    let answer2 = dict["answer2"] as? String
                    let answer3 = dict["answer3"] as? String
                    let answer4 = dict["answer4"] as? String
                    let count1 = dict["count1"] as? String
                    let count2 = dict["count2"] as? String
                    let count3 = dict["count3"] as? String
                    let count4 = dict["count4"] as? String
                    let newQuestion = Question(title:question!, answers:[answer1!,answer2!,answer3!,answer4!],answersCount:[count1!,count2!,count3!,count4!],type: type1!,response: "")
                    self.allQuestions.append(newQuestion)
                }
                
                if type1 == "longAnswer"{
                    let response = dict["numResponse"] as? String
                    let newQuestion = Question(title:question!, answers:[],answersCount:[],type: type1!,response: response!)
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
    
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        
        
        
        //ref?.child("Surveys/\(key!)").updateChildValues(["numOfQuestions":numOfQuestions])
        //Handle results with taskViewController.result
        var count = 1
        for question in allQuestions {
            if question.type == "multipleChoice" {
                if let stepResult = taskViewController.result.stepResult(forStepIdentifier: String(count)),
                    let stepResults = stepResult.results,
                    let stepFirstResult = stepResults.first,
                    let choiceResult = stepFirstResult as? ORKChoiceQuestionResult,
                    let choiceAnswer = choiceResult.choiceAnswers {
                    let index = choiceAnswer as? [String]
                    let temp = choiceAnswer[0] as! Int
                    var num = ""
                    var amount = ""
                    if temp == 0{
                        num = "1"
                        amount = question.answersCount[0]
                    }
                    if temp == 1{
                        num = "2"
                        amount = question.answersCount[1]
                    }
                    if temp == 2{
                        num = "3"
                        amount = question.answersCount[2]
                    }
                    if temp == 3{
                        num = "4"
                        amount = question.answersCount[3]
                    }
                    var holder = Int(amount)
                    holder = holder! + 1
                    amount = String(holder!)
                    
                    
                    ref.child("Surveys/\(surveyID)/Questions/\(String(count))").updateChildValues(["count" + num: amount])
                    
                    print("Result for MC question: \(choiceAnswer[0])")
                }
            }
            if question.type == "longAnswer" {
                if let stepResult = taskViewController.result.stepResult(forStepIdentifier: String(count)),
                    let stepResults = stepResult.results,
                    let stepFirstResult = stepResults.first,
                    let longResult = stepFirstResult as? ORKTextQuestionResult,
                    let longAnswer = longResult.textAnswer {
                    let response = question.response
                    pushLongAnswerToFireBase(data: longAnswer, count: count,response: response)
                    print("Result for long answer question: \(longAnswer)")
                }
            }
            count = count + 1
        }
        
        taskViewController.dismiss(animated: true, completion: nil)
    }
    
    
    func pushLongAnswerToFireBase(data:String, count:Int, response:String){
        
        var num: Int
        num = Int(response)!
        num = num + 1
        self.numOfResponses = String(num)
        ref.child("Surveys/\(surveyID)/Questions/\(String(count))").updateChildValues(["response" + numOfResponses:data, "numResponse":self.numOfResponses])
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
    
    
}
