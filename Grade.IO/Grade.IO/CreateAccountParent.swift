//
//  CreateAccountParent.swift
//  Grade.IO
//
//  Created by user183542 on 1/17/21.
//

import UIKit

class CreateAccountParent : UIViewController {
    
    @IBOutlet weak var fFirstName: UITextField!
    @IBOutlet weak var fLastName: UITextField!
    @IBOutlet weak var fEmail: UITextField!
    @IBOutlet weak var fPhoneNumber: UITextField!
    @IBOutlet weak var fPassword: UITextField!
    @IBOutlet weak var fPasswordConfirm: UITextField!

    @IBOutlet weak var bSignUp: UIButton!
    
    
    @IBAction func bSignUpPressed(_ sender: Any) {
        if (!isValid()) {
            if (fPassword.text! == fPasswordConfirm.text!) {
                DoAlert(title:"error", body:"Password and Confirm Password must match", vc: self )
            }
            else {
                DoAlert(title:"error", body:"All fields are required", vc: self )
            }
        }
        else {
            CurrentUser = Parent()
            UserHelper.GenerateUserName(firstName:fFirstName.text!, lastName:fLastName.text!, type: Strings.PARENT) { newUserName in
                AuthCommands.createUserWithEmail(email:newUserName + Strings.ARBITRARY_EMAIL, password:self.fPassword.text!) { success in
                    if (!success) {
                        DoAlert(title: "error", body: "Could not create account. Contact support", vc: self)
                    }
                    else {
                        CurrentUser = Parent()
                        CurrentUser.id = newUserName
                        CurrentUser.SetEmail(newEmail: self.fEmail.text!)
                        CurrentUser.SetFirstName(newFirstName: self.fFirstName.text!)
                        CurrentUser.SetLastName(newLastName: self.fLastName.text!)
                        (CurrentUser as! Parent).SetPhoneNumber(newNumber: self.fPhoneNumber.text!)
                        //userNameAlert(vc: self)
                        //self.performSegue(withIdentifier:"parentCreateToHome", sender: self)
                    }
                }
            }
        }
    }
    
    private func isValid() -> Bool {
        var passwordOK = AuthCommands.passwordOK(password: fPassword.text!, confirm: fPasswordConfirm.text!)
        return passwordOK && AllFieldsFull()
    }
    private func AllFieldsFull() -> Bool {
        return !fEmail.text!.isEmpty  && !fPhoneNumber.text!.isEmpty && !fPassword.text!.isEmpty && !fPasswordConfirm.text!.isEmpty &&
            !fFirstName.text!.isEmpty && !fLastName.text!.isEmpty
    }
}
