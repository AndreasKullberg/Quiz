//
//  ViewController.swift
//  Quiz
//
//  Created by Andreas Kullberg on 2019-03-18.
//  Copyright © 2019 Andreas Kullberg. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("question\(1)")
        
        /*FirebaseApp.configure()
        let db = Firestore.firestore()
        let docRef = db.collection("Zlatan").document("question1")
        
        //let question = Question(question: "Hur stor näsa har Zlatan", answerA: "Väldigt stor")
        
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
            }
        }
        db.collection("Zlatan").document().setData(question) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        print(question.answerA)*/
        
    }


}

