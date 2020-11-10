//
//  ViewController.swift
//  test
//
//  Created by user183542 on 11/8/20.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var userNameField: UITextField!
    
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var textView: UITextView!;
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        userNameField.delegate = self
        passwordField.delegate = self
    }
    
   
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

