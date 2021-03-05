//
//  CreateAccountTeacher.swift
//  Grade.IO
//
//  Created by user183542 on 1/17/21.
//
import UIKit
class CreateAccountTeacher : UIViewController {
    
    @IBOutlet weak var fFirstName: UITextField!
    @IBOutlet weak var fConfirmPassword: UITextField!
    @IBOutlet weak var fPassword: UITextField!
    @IBOutlet weak var fEmail: UITextField!
    @IBOutlet weak var fPhoneNumber: UITextField!
    @IBOutlet weak var fLastName: UITextField!
    
    
    @IBOutlet weak var bSignUp: UIButton!
    @IBAction func signUpPressed(_ sender: Any) {
        if (!isValid()) {
            if (fPassword.text! == fConfirmPassword.text!) {
                DoAlert(title:"error", body:"Password and Confirm Password must match", vc: self )
            }
            else {
                DoAlert(title:"error", body:"All fields are required", vc: self )
            }
        }
        else {
            UserHelper.GenerateUserName(firstName:fFirstName.text!, lastName:fLastName.text!, type: Strings.TEACHER) { newUserName in
                AuthCommands.createUserWithEmail(email:newUserName + Strings.ARBITRARY_EMAIL, password:self.fPassword.text!) { success in
                    if (!success) {
                        DoAlert(title: "error", body: "Could not create account. Contact support", vc: self)
                    }
                    else {
                        CurrentUser = Teacher(id:newUserName)
                        CurrentUser.SetEmail(newEmail: self.fEmail.text!)
                        CurrentUser.SetFirstName(newFirstName: self.fFirstName.text!)
                        CurrentUser.SetLastName(newLastName: self.fLastName.text!)
                        (CurrentUser as! Teacher).SetPhoneNumber(newNumber: self.fPhoneNumber.text!)
                        //userNameAlert(vc: self)
                        self.performSegue(withIdentifier:"teacherCreateToHome", sender: self)
                    }
                }
            }
        }
    }
    private func isValid() -> Bool {
        var passwordOK = AuthCommands.passwordOK(password: fPassword.text!, confirm: fConfirmPassword.text!)
        return passwordOK && AllFieldsFull()
    }
    private func AllFieldsFull() -> Bool {
        return !fEmail.text!.isEmpty  && !fPhoneNumber.text!.isEmpty && !fPassword.text!.isEmpty && !fConfirmPassword.text!.isEmpty &&
            !fFirstName.text!.isEmpty && !fLastName.text!.isEmpty
    }
}
