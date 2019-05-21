//
//  CreateQuizViewController.swift
//  Quiz
//
//  Created by Andreas Kullberg on 2019-03-22.
//  Copyright © 2019 Andreas Kullberg. All rights reserved.
//

import UIKit
import Firebase

class CreateQuizViewController: UIViewController {

    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var finishQuizOutlet: UIButton!
    @IBOutlet weak var addQuestionOutlet: UIButton!
    
    @IBOutlet weak var cancelOutlet: UIButton!
    @IBOutlet weak var questionTextfield: UITextField!
    @IBOutlet weak var rightAnswerTextfield: UITextField!
    
    @IBOutlet weak var wrongAnswerCTextfield: UITextField!
    @IBOutlet weak var wrongAnswerBTextfield: UITextField!
    @IBOutlet weak var wrongAnswerATextfield: UITextField!
    var quiz = Quiz()
    var quizName = ""
    var questionNumber = 1
    var image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        disableAddQuestionButton()
        hideKeyboard()
        
        questionNumberLabel.text = "Question \(questionNumber)"
        finishQuizOutlet.isUserInteractionEnabled = false
        let cornerRadius : CGFloat = 5.0
        finishQuizOutlet.layer.cornerRadius = cornerRadius
        addQuestionOutlet.layer.cornerRadius = cornerRadius
        cancelOutlet.layer.cornerRadius = cornerRadius
        
    }
    
   
    
    @IBAction func createQuizButton(_ sender: Any) {
        let db = Firestore.firestore()
        
        addQuizToQuizCollection(db)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addQuestionButton(_ sender: Any) {
        disableAddQuestionButton()
        let question = Question(question: questionTextfield.text!, answerA: rightAnswerTextfield.text!, answerB: wrongAnswerATextfield.text!, answerC: wrongAnswerBTextfield.text!, answerD: wrongAnswerCTextfield.text!, rightAnswer: rightAnswerTextfield.text!)
        quiz.questions.append(question)
        
        self.questionNumber = self.questionNumber + 1
        self.questionNumberLabel.text = "Question \(self.questionNumber)"
        questionTextfield.text = ""
        rightAnswerTextfield.text = ""
        wrongAnswerATextfield.text = ""
        wrongAnswerBTextfield.text = ""
        wrongAnswerCTextfield.text = ""
        finishQuizOutlet.isUserInteractionEnabled = true
    }
    
    @IBAction func cancelButton(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    
    
    fileprivate func addQuizToQuizCollection(_ db: Firestore) {
        for i in 0...quiz.questions.count-1{
            db.collection(quizName).document("question\(i+1)").setData(quiz.questions[i].uploadDictionary) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                    self.addQuiz(db)
                    
                }
            }
        }
    }
    
    fileprivate func addQuiz(_ db: Firestore) {
        var quizNameDictionary: [String: String] = [:]
            quizNameDictionary = ["name": quizName]
        
       
        db.collection("Quizzes").document(quizName).setData(quizNameDictionary) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
               
        }
    }
        
    }
  
   /* func uploadMedia(completion: @escaping (_ url: String?) -> Void) {
        let storageRef = Storage.storage().reference().child("myImage.png")
        if let uploadData = image.jpegData(compressionQuality: 0.75) {
            storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                if error != nil {
                    print("error")
                    completion(nil)
                } else {
                    completion(metadata?.d)
                    // your uploaded photo url.
                }
            }
        }
    }*/

    @IBAction func rightAnswerIsChanged(_ sender: Any) {
        checkTextfield()
    }
    @IBAction func questionIsChanged(_ sender: Any) {
        checkTextfield()
    }
    
    @IBAction func answerAIsChanged(_ sender: Any) {
        checkTextfield()
    }
    
    @IBAction func answerBIsChanged(_ sender: Any) {
        checkTextfield()
    }
    
    @IBAction func answerCIsChanged(_ sender: Any) {
        checkTextfield()
    }
    
    func enableAddQuestionButton(){
        addQuestionOutlet.isUserInteractionEnabled = true
    }
    func disableAddQuestionButton(){
        addQuestionOutlet.isUserInteractionEnabled = false
    }
    func checkTextfield() {
        if (!questionTextfield.text!.isEmpty && !rightAnswerTextfield.text!.isEmpty &&
            !wrongAnswerATextfield.text!.isEmpty && !wrongAnswerBTextfield.text!.isEmpty
            && !wrongAnswerCTextfield.text!.isEmpty){
            enableAddQuestionButton()
        }
        else{
            disableAddQuestionButton()
        }
    }
    
}
extension CreateQuizViewController {
    
    func hideKeyboard() {
        let Tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(Tap)
    }
    @objc func dismissKeyboard()  {
        view.endEditing(true)
    }
}
