//
//  StartQuizViewController.swift
//  Quiz
//
//  Created by Andreas Kullberg on 2019-03-27.
//  Copyright © 2019 Andreas Kullberg. All rights reserved.
//

import UIKit

class StartQuizViewController: UIViewController, rightAnswersProtocol {
    func sendRightAnswer(isPlayed: Bool, rightAnswers: Int, questionCount: Int) {
        self.rightAnswers = rightAnswers
        self.isPlayed = isPlayed
        self.questionCount = questionCount
    }
    
    @IBOutlet weak var quizNameLabel: UILabel!
    
    @IBOutlet weak var startQuizOutlet: UIButton!
    @IBOutlet weak var showResultLabel: UILabel!
    
    var quizName = ""
    var rightAnswers = 0
    var isPlayed = false
    var questionCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Start Quiz"
        let cornerRadius : CGFloat = 5.0
        startQuizOutlet.layer.cornerRadius = cornerRadius
        quizNameLabel.text = quizName
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(rightAnswers)
        if (isPlayed){
            startQuizOutlet.setTitle("Play Again", for: .normal)
            showResultLabel.text = "Right answers: \(rightAnswers) of \(questionCount)"
        }
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openPlayQuiz" {
            
            
                let destinationVC = segue.destination as! PlayGameViewController
                destinationVC.quizName = quizName
                destinationVC.delegate = self
        
        }
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
