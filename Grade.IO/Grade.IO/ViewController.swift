//
//  ViewController.swift
//  Grade.IO
//
//  Created by user183542 on 11/22/20.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController {
    
    //setting variables for email and password on login screen
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var signInButton: GIDSignInButton!

    override func viewDidLoad() {
        emailField.delegate = self
        passwordField.delegate = self
        googleOnStartLoginWork()
        super.viewDidLoad()
    }

    //this function handles input on the login screen
    @IBAction func loginPressed(_ sender: Any) {
     //there are two variables that can be accessed here
     //Email: "emailField.text!"
     //Password: "passwordField.text
        AuthCommands.signOutWithErrorCatch()
    }
    
    //this function handles input on the create an account page
    @IBAction func createAccountPressed(_ sender: Any) {
     //variables are being funky on this page so they will be soon to come
    }
    
    //this function handles when the google sign in is pressed
    // MATT 11/29/2020 : I don't think we need this anymore.
    @IBAction func googleSignInPressed(_ sender: Any) {}
    
    /// calls to make on ViewDidLoad for google auth
    func googleOnStartLoginWork() {
        GIDSignIn.sharedInstance()?.presentingViewController = self
    }
}

extension ViewController : UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

