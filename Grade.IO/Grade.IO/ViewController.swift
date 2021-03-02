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
        super.viewDidLoad()
        AuthCommands.signOutWithErrorCatch()
        passwordField.isSecureTextEntry = true
        
        DatabaseHelper.GetClassroomFromID(classID: "t_gibbsmat_550") { res in
            currentClassroom = res
            currentClassroom.Listen()
        }
    }
    
    //this function handles input on the login screen
    @IBAction func loginPressed(_ sender: Any) {
        signInWithEmail(email: emailField.text! + Strings.ARBITRARY_EMAIL, password: passwordField.text!)
        checkCredentials()
    }
    
    //this function handles input on the create an account page
    @IBAction func createAccountPressed(_ sender: Any) {
     //variables are being funky on this page so they will be soon to come
    }
    
    func checkCredentials() {
        if (Auth.auth().currentUser != nil) {
            UserHelper.GetUserByID(id:emailField.text!) { res in
                CurrentUser = res
                CurrentUser.Listen()
                self.PerformSignInSegue()
            }
        }
    }
    
    func PerformSignInSegue() {
        switch CurrentUser.id?.first {
        case "s" :
            performSegue(withIdentifier: "signInToHomeScreen_STUDENT", sender: self)
        case "t" :
            performSegue(withIdentifier: "signInToHomeScreen_TEACHER", sender: self)
        case "p" :
            performSegue(withIdentifier: "signInToHomeScreen_PARENT", sender: self)
        default:
            break
        }
    }

    // TO SIGN IN  WITH EMAIL
   func signInWithEmail(email: String, password: String) {
        Auth.auth().signIn(withEmail:  email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
        }
    }
    
    func signOutWithErrorCatch() {
        do {
            try Auth.auth().signOut()
        }
        catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }

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
