//
//  ViewController.swift
//  QMee
//
//  Created by Богдан Быстрицкий on 17.09.17.
//  Copyright © 2017 Developers Academy. All rights reserved.
//

import UIKit

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
            print("Great! Correct.")
            score += 100
        } else {
            print("Wrong.")
            score -= 50
        }
        
    }
    
    func nextQuestion() {
        
        if questionNumber != allQuestions.list.count {
            
            questionLabel.text = allQuestions.list[questionNumber].questionText
            updateUI()
            
        } else {

            let alert = UIAlertController(title: "Awesome", message: "You've finished all questions. Do you want to start over?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler: { (UIAlertAction) in
                self.startOver()
            })
            
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
            
        }
    }
    
    func startOver() {
        
        questionNumber = 0
        score = 0
        nextQuestion()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
}

