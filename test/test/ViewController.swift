//
//  ViewController.swift
//  test
//
//  Created by user183542 on 11/8/20.
//

import UIKit

class ViewController: UIViewController {

    //Variable to hold username
    @IBOutlet weak var userNameField: UITextField!
    
    //Variable to hold password
    @IBOutlet weak var passwordField: UITextField!
    
    //TextBox input variable
    @IBOutlet weak var textView: UITextView!;
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        userNameField.delegate = self
        passwordField.delegate = self
        
        //Hides password entry
        passwordField.isSecureTextEntry = true
    }
    
   //function prints username and password to screen once "View Results" is hit
    @IBAction func enterTapped(_ sender: Any) {
        textView.text = "UserName: \(userNameField.text!)\nPassword: \(passwordField.text!)"
    }
   
}

extension ViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

