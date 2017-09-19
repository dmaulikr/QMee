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
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var trueLabel: UILabel!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseLabel: UILabel!
    @IBOutlet weak var falseButton: UIButton!
    
    @IBOutlet weak var addQuestionsButton: UIButton!
    let allQuestions = QuestionBank()
    var pickedAnswer : Bool = false
    var questionNumber : Int = 0
    var score : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame(startGameBool: true)
        
    }
    
    
    @IBAction func addQuestionsDidTapped(_ sender: Any) {
        
        addNewQuestion()
        
    }
    
    
    @IBAction func startButtonDidTapped(_ sender: Any) {
        nextQuestion()
        startNewGame(startGameBool: false)
        ruleGames()

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
        
        scoreLabel.text = "Score: \(score)"
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
            
            scoreLabel.text = "Score: \(score)"
            if score == allQuestions.list.count * 100 {

            let appearance = SCLAlertView.SCLAppearance(
                showCloseButton: false
            )
            let alertView = SCLAlertView(appearance: appearance)
            alertView.addButton("Restart") {
                self.startOver()
            }
            alertView.addButton("Back to Menu") {
                self.viewDidLoad()
            }
            alertView.showSuccess("Awesome", subTitle: "You've finished all questions. Your score is \(score).")
                
            } else {
                
                let appearance = SCLAlertView.SCLAppearance(
                    showCloseButton: false
                )
                let alertView = SCLAlertView(appearance: appearance)
                alertView.addButton("Restart") {
                    self.startOver()
                }
                alertView.addButton("Back to Menu") {
                    self.viewDidLoad()
                }
                alertView.showError("Failure", subTitle: "You've finished all questions. Your score is \(score).")
            }
            
        }
    }
    
    func startOver() {
        
        questionNumber = 0
        score = 0
        nextQuestion()
        
    }
    
    func ruleGames () {
        
        SCLAlertView().showInfo("Rule", subTitle: "For correct answer you get 100 points. For incorrect deducted 50 points. The goal of the game to score \(allQuestions.list.count*100) points")
        
    }
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    func addNewQuestion() {
        // Add a text field
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        let alert = SCLAlertView(appearance: appearance)
        let question = alert.addTextField("Question")
        let answerStringNotBool = alert.addTextField("True or False")
        alert.addButton("To add") {
            let answerBool = answerStringNotBool.text?.lowercased()
            let returnValue = answerBool! == "true" || answerBool == "1" || answerBool == "yes"
            self.allQuestions.list.append(Question(text: question.text!, correctAnswer: returnValue))
        }
        alert.showEdit("To add new question", subTitle: "")
    }
    
    
    //if startGameBool = true , then was been start game
    //if startGameBool = false, then was been start game from button 'back to menu'
    func startNewGame(startGameBool: Bool) {
        score = 0
        questionNumber = 0
        
        startButton.isHidden = !startGameBool
        addQuestionsButton.isHidden = !startGameBool
    
        questionLabel.isHidden = startGameBool
        progressLabel.isHidden = startGameBool
        progressBar.isHidden = startGameBool
        scoreLabel.isHidden = startGameBool
        trueButton.isHidden = startGameBool
        trueLabel.isHidden = startGameBool
        falseButton.isHidden = startGameBool
        falseLabel.isHidden = startGameBool
    }
    
}

