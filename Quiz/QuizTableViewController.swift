//
//  QuizTableViewController.swift
//  Quiz
//
//  Created by Andreas Kullberg on 2019-03-22.
//  Copyright © 2019 Andreas Kullberg. All rights reserved.
//

import UIKit
import Firebase

class QuizTableViewController: UITableViewController {
     var quizes: [Quiz] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Quizzes"
       

    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.enableAllOrientation = true
        retrieveQuizes()
    }
   
    fileprivate func retrieveQuizes() {
        let db = Firestore.firestore()
        
        db.collection("Quizzes").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let tempQuiz = Quiz()
                    tempQuiz.name = document.data()["name"] as! String
                    self.quizes.append(tempQuiz)
                    self.tableView.reloadData()
                    
                }
            }
        }
        tableView.reloadData()
    }
    
   
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return quizes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! QuizTableViewCell
        let quiz: Quiz
        quiz = quizes[indexPath.row]
        cell.quizNameLabel.text = quiz.name
        

        return cell
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openStartQuiz" {
            if let indexPath = tableView.indexPathForSelectedRow{
                let destinationVC = segue.destination as! StartQuizViewController
                destinationVC.quizName = self.quizes[indexPath.row].name
                
            }
            
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.enableAllOrientation = false
        
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        quizes.removeAll()
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
