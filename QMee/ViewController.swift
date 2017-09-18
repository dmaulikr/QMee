//
//  ViewController.swift
//  QMee
//
//  Created by Богдан Быстрицкий on 17.09.17.
//  Copyright © 2017 Developers Academy. All rights reserved.
//

import UIKit
import SCLAlertView

class ViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    let allQuestions = QuestionBank()
    var pickedAnswer : Bool = false
    var questionNumber : Int = 0
    var score : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextQuestion()
        
    }
    
    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            pickedAnswer = true
        } else if sender.tag == 2 {
            pickedAnswer = false
        }
        
        checkAnswer()
        questionNumber += 1
        nextQuestion()
    }

    
    
    func updateUI() {
        
        scoreLabel.text = "\(score)"
        progressLabel.text = "\(questionNumber+1)/\(allQuestions.list.count)"
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNumber + 1)
        
    }
    
    
    func checkAnswer() {
        
        let correctAnswer = allQuestions.list[questionNumber].answer
        
        if correctAnswer == pickedAnswer {
            
            ProgressHUD.showSuccess("Correct")
            score += 100
        } else {
            score -= 50
            ProgressHUD.showError("Wrong")
        }
        
    }
    
    
    func nextQuestion() {
        
        if questionNumber != allQuestions.list.count {
            
            questionLabel.text = allQuestions.list[questionNumber].questionText
            updateUI()
            
        } else {
            
            if score == allQuestions.list.count * 100 {

            let appearance = SCLAlertView.SCLAppearance(
                showCloseButton: false
            )
            let alertView = SCLAlertView(appearance: appearance)
            alertView.addButton("Restart") {
                self.startOver()
            }
            alertView.showSuccess("Awesome", subTitle: "You've finished all questions. Your score is \(score). Do you want to start over?")
                
            } else {
                
                let appearance = SCLAlertView.SCLAppearance(
                    showCloseButton: false
                )
                let alertView = SCLAlertView(appearance: appearance)
                alertView.addButton("Restart") {
                    self.startOver()
                }
                alertView.showError("Failure", subTitle: "You've finished all questions. Your score is \(score). Do you want to start over?")
            }
            
        }
    }
    
    func startOver() {
        
        questionNumber = 0
        score = 0
        nextQuestion()
        
    }
    
    func ruleGames () {
        
    }
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
}

