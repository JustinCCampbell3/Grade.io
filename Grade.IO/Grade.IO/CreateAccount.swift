//
//  Homepage.swift
//  Grade.IO
//
//  Created by user183573 on 11/30/20.
//

import UIKit
import FSCalendar
import FirebaseAuth
import FirebaseFirestore
class CreateAccount : UIViewController {
    @IBOutlet weak var emailField:UITextField!
    @IBOutlet weak var passwordField:UITextField!
    @IBOutlet weak var createAccountButton:UIButton!

    @IBOutlet weak var bParent: UIButton!
    @IBOutlet weak var bStudent: UIButton!
    @IBOutlet weak var bTeacher: UIButton!
    
    
    @IBAction func bParentClicked(_ sender: Any) {
        CurrentUser.UserType = EUserType.Parent
    }
    @IBAction func bStudentClicked(_ sender: Any) {
        CurrentUser.UserType = EUserType.Student
    }
    @IBAction func bTeacherClicked(_ sender: Any) {
        CurrentUser.UserType = EUserType.Teacher
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        //AuthCommands.createUserWithEmail(email: emailField.text!, password: passwordField.text!)
        //UserHelper.GetUserByID(type:CurrentUser.UserType, id: "GibbsMat") { res in
         //   CurrentUser = res
        //    self.performSegue(withIdentifier: "createAccountToHome", sender:self)
       // }
    }
}
    
