//
//  Question.swift
//  Quiz
//
//  Created by Andreas Kullberg on 2019-03-18.
//  Copyright © 2019 Andreas Kullberg. All rights reserved.
//

import UIKit

class Question: NSObject {
    
    var qusetion = ""
    var answerA = ""
    var answerB = ""
    var answerC = ""
    var answerD = ""
    var rightAnswer = ""
    var id = ""
    var uploadDictionary: [String: String] = [:]
    
    init(question:String, answerA: String, answerB: String, answerC: String,
         answerD: String, rightAnswer: String)  {
        self.qusetion = question
        self.answerA = answerA
        self.answerB = answerB
        self.answerC = answerC
        self.answerD = answerD
        self.rightAnswer = rightAnswer
        uploadDictionary = ["question": question, "answerA": answerA, "answerB": answerB,
                     "answerC": answerC, "answerD": answerD, "rightAnswer": rightAnswer]
    }
    

}
