//
//  Homepage.swift
//  Grade.IO
//
//  Created by user183573 on 11/30/20.
//

import UIKit
import FSCalendar
import FirebaseAuth

class CreateAccount : UIViewController {
    @IBOutlet weak var emailField:UITextField!
    @IBOutlet weak var passwordField:UITextField!
    @IBOutlet weak var createAccountButton:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        AuthCommands.createUserWithEmail(email: emailField.text!, password: passwordField.text!)
        
        performSegue(withIdentifier: "createAccountToHome", sender: self)
        
    }
    
}
