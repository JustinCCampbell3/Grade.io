//
//  ViewController.swift
//  Grade.IO
//
//  Created by user183542 on 11/22/20.
//

import UIKit
import Firebase
import GoogleSignIn
import FSCalendar

class ViewController: UIViewController{
    
    //setting variables for email and password on login screen
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var signInButton: GIDSignInButton!

    //variable for calendar function
    //@IBOutlet var calendarView:FSCalendar!
    
    override func viewDidLoad() {
        emailField.delegate = self
        passwordField.delegate = self
        googleOnStartLoginWork()
        super.viewDidLoad()
        
        //setupCalendar()
        
    }

    //func setupCalendar(){
        //calendarView.delegate = self
    //}

    
    //this function handles input on the login screen
    @IBAction func loginPressed(_ sender: Any) {
     //there are two variables that can be accessed here
     //Email: "emailField.text!"
     //Password: "passwordField.text
    }
    
    //this function handles input on the create an account page
    @IBAction func createAccountPressed(_ sender: Any) {
     //variables are being funky on this page so they will be soon to come
    }
    
    //this function handles when the google sign in is pressed
    // MATT 11/29/2020 : I don't think we need this anymore.
    @IBAction func googleSignInPressed(_ sender: Any) {}
    
}

extension ViewController : UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//extension ViewController : FSCalendarDelegate{
//    //allows user to select a date and then will run the code inside of it
//    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
//        //will hold the date and time
//        let dFormatter = DateFormatter()
//        dFormatter.dateFormat = "EEEE MM-dd-YYYY"
        
//        //will get the string version of the date and time
//        let dateString = dFormatter.string(from: date)
//        print("\(dateString)")
//    }}
