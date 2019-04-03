//
//  PlayGameViewController.swift
//  Quiz
//
//  Created by Andreas Kullberg on 2019-03-22.
//  Copyright © 2019 Andreas Kullberg. All rights reserved.
//

import UIKit
import Firebase
protocol rightAnswersProtocol {
    func sendRightAnswer(isPlayed: Bool, rightAnswers: Int, questionCount: Int)
    
}

class PlayGameViewController: UIViewController, rightAnswersProtocol {
    func sendRightAnswer(isPlayed: Bool, rightAnswers: Int, questionCount: Int) {
        
    }
    
    var quizName = ""
    var questionNumber = 0
    let tempQuiz = Quiz()
    var rightAnswers = 0
    var delegate:rightAnswersProtocol?
    

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var quizNameLabel: UILabel!
    
    @IBOutlet weak var answerAOutlet: UIButton!
    @IBOutlet weak var answerCOutlet: UIButton!
    @IBOutlet weak var answerDOutlet: UIButton!
    
    @IBOutlet weak var answerBOutlet: UIButton!
    
    @IBOutlet weak var cancelOutlet: UIButton!
    
    @IBOutlet weak var nextOutlet: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        disableButtons()
        
        let db = Firestore.firestore()
        let cornerRadius : CGFloat = 5.0
        answerAOutlet.layer.cornerRadius = cornerRadius
        answerBOutlet.layer.cornerRadius = cornerRadius
        answerCOutlet.layer.cornerRadius = cornerRadius
        answerDOutlet.layer.cornerRadius = cornerRadius
        nextOutlet.layer.cornerRadius = cornerRadius
        cancelOutlet.layer.cornerRadius = cornerRadius
        
        quizNameLabel.text = "Question \(questionNumber+1)"
  
        db.collection(quizName).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    
                    let question = Question(question: document.data()["question"] as! String, answerA: document.data()["answerA"] as! String, answerB: document.data()["answerB"] as! String, answerC: document.data()["answerC"] as! String, answerD: document.data()["answerD"] as! String, rightAnswer: document.data()["rightAnswer"] as! String)
                    self.tempQuiz.questions.append(question)
                    self.newQuestion(self.tempQuiz)
                    self.enableButtons()
                }
            }
            
        }
    
    }
    
    
    @IBAction func answerAButton(_ sender: Any) {
    if((answerAOutlet.currentTitle?.elementsEqual(self.tempQuiz.questions[questionNumber].rightAnswer))! ) {
            print("Right answer")
            answerAOutlet.backgroundColor = UIColor.green
            rightAnswers = rightAnswers + 1
        }
        else{
            answerAOutlet.backgroundColor = UIColor.red
        
        }
        increaseQuestionNumber()
        disableButtons()
        enableNextButton()
    }
    
    @IBAction func answerBButton(_ sender: Any) {
    if((answerBOutlet.currentTitle?.elementsEqual(self.tempQuiz.questions[questionNumber].rightAnswer))! ) {
            print("Right answer")
            answerBOutlet.backgroundColor = UIColor.green
            rightAnswers = rightAnswers + 1
        }
        else{
            answerBOutlet.backgroundColor = UIColor.red
            
        }
        increaseQuestionNumber()
        disableButtons()
        enableNextButton()
    }
    
    @IBAction func answerCButton(_ sender: Any) {
    if((answerCOutlet.currentTitle?.elementsEqual(self.tempQuiz.questions[questionNumber].rightAnswer))! ) {
            print("Right answer")
            answerCOutlet.backgroundColor = UIColor.green
            rightAnswers = rightAnswers + 1
        }
        else{
            answerCOutlet.backgroundColor = UIColor.red
        enableNextButton()
            
        }
        increaseQuestionNumber()
        disableButtons()
        enableNextButton()
    }
    
    @IBAction func answerDButton(_ sender: Any) {
    if((answerDOutlet.currentTitle?.elementsEqual(self.tempQuiz.questions[questionNumber].rightAnswer))! ) {
            print("Right answer")
            answerDOutlet.backgroundColor = UIColor.green
            rightAnswers = rightAnswers + 1
        }
        else{
            answerDOutlet.backgroundColor = UIColor.red
            
        }
        increaseQuestionNumber()
        disableButtons()
        enableNextButton()
    }
   
    @IBAction func nextQuestionButton(_ sender: Any) {
        
        if (questionNumber == tempQuiz.questions.count){
            dismiss(animated: true, completion: nil)
            delegate!.sendRightAnswer(isPlayed: true, rightAnswers: rightAnswers, questionCount: questionNumber)
        }
        else{
            answerAOutlet.backgroundColor = UIColor.lightGray
            answerBOutlet.backgroundColor = UIColor.lightGray
            answerCOutlet.backgroundColor = UIColor.lightGray
            answerDOutlet.backgroundColor = UIColor.lightGray
            self.newQuestion(tempQuiz)
            enableButtons()
            disableNextButton()
            quizNameLabel.text = "Question \(questionNumber+1)"
            
            
        }
        
    }
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    fileprivate func disableButtons() {
        answerAOutlet.isUserInteractionEnabled = false
        answerBOutlet.isUserInteractionEnabled = false
        answerCOutlet.isUserInteractionEnabled = false
        answerDOutlet.isUserInteractionEnabled = false
    }
    
    func enableButtons() {
        answerAOutlet.isUserInteractionEnabled = true
        answerBOutlet.isUserInteractionEnabled = true
        answerCOutlet.isUserInteractionEnabled = true
        answerDOutlet.isUserInteractionEnabled = true
    }
    func enableNextButton(){
        nextOutlet.isUserInteractionEnabled = true
    }
    func disableNextButton(){
        nextOutlet.isUserInteractionEnabled = false
    }
    
    fileprivate func increaseQuestionNumber() {
        questionNumber = questionNumber + 1
        if (questionNumber == tempQuiz.questions.count){
            nextOutlet.setTitle("See result", for: .normal)
        }
    }
    
    fileprivate func newQuestion(_ tempQuiz: Quiz) {
        var wordArray = [tempQuiz.questions[self.questionNumber].answerA, tempQuiz.questions[self.questionNumber].answerB, tempQuiz.questions[self.questionNumber].answerC, tempQuiz.questions[self.questionNumber].answerD]
        var number = Int.random(in: 0 ..< wordArray.count)
        
        self.answerAOutlet.setTitle(wordArray[number], for: .normal)
        wordArray.remove(at: number)
        number = Int.random(in: 0 ..< wordArray.count)
        self.answerBOutlet.setTitle(wordArray[number], for: .normal)
        wordArray.remove(at: number)
        number = Int.random(in: 0 ..< wordArray.count)
        self.answerCOutlet.setTitle(wordArray[number], for: .normal)
        wordArray.remove(at: number)
        number = Int.random(in: 0 ..< wordArray.count)
        self.answerDOutlet.setTitle(wordArray[number], for: .normal)
        self.questionLabel.text = "\(tempQuiz.questions[self.questionNumber].qusetion) ?"
    }
    
}
