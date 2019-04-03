//
//  PickPhotoViewController.swift
//  Quiz
//
//  Created by Andreas Kullberg on 2019-03-27.
//  Copyright © 2019 Andreas Kullberg. All rights reserved.
//

import UIKit

class PickPhotoViewController: UIViewController {
    var imagePicker = UIImagePickerController()
    var image = UIImage()

    @IBOutlet weak var nextStepOutlet: UIButton!
    @IBOutlet weak var pickPhotoOutlet: UIButton!
    @IBOutlet weak var quizNameTextfield: UITextField!
    @IBOutlet weak var imgOutlet: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
        self.navigationItem.title = "Create Quiz"
        let cornerRadius : CGFloat = 5.0
        nextStepOutlet.layer.cornerRadius = cornerRadius
        pickPhotoOutlet.layer.cornerRadius = cornerRadius
        imagePicker.delegate = self
    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if(!quizNameTextfield.text!.isEmpty){
            nextStepOutlet.isUserInteractionEnabled = true
        }
        else{
            nextStepOutlet.isUserInteractionEnabled = false
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func pickPhotoButton(_ sender: UIButton) {
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        
            if segue.identifier == "openCreateQuiz" {
                
                let destinationVC = segue.destination as! CreateQuizViewController
                destinationVC.quizName = quizNameTextfield.text!
                destinationVC.image = image
                quizNameTextfield.text = ""
                imgOutlet.image = nil
                
                
            }
      
    }
    
    @IBAction func textfieldDidChange(_ sender: Any) {
        if(!quizNameTextfield.text!.isEmpty){
            nextStepOutlet.isUserInteractionEnabled = true
        }
        else{
            nextStepOutlet.isUserInteractionEnabled = false
        }
        
    }
    
    
}

extension PickPhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.editedImage]{
            imgOutlet.image = (pickedImage as! UIImage)
            image = pickedImage as! UIImage
            
        }
            
        
            
        
        dismiss(animated: true, completion: nil)
    }
    
    func hideKeyboard() {
        let Tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(Tap)
    }
    @objc func dismissKeyboard()  {
        view.endEditing(true)
    }
}


