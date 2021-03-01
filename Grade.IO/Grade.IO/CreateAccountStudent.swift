//
//  CreateAccountStudent.swift
//  Grade.IO
//
//  Created by user183542 on 1/17/21.
//

import UIKit
class CreateAccountStudent : UIViewController {
    
    @IBOutlet weak var fFirstName: UITextField!
    
    @IBOutlet weak var fLastName: UITextField!
    
    @IBOutlet weak var fPassword: UITextField!
    
    @IBOutlet weak var bSignUp: UIButton!
    @IBOutlet weak var fConfirmPassword: UITextField!
    
    @IBOutlet weak var fParentCode: UITextField!
    
    @IBOutlet weak var bSignUpButton: UIButton!
    @IBAction func signUpPressed(_ sender: Any) {
        UserHelper.GenerateUserName(firstName:fFirstName.text!, lastName:fLastName.text!, type: Strings.STUDENT) { newUserName in
            AuthCommands.createUserWithEmail(email:newUserName + Strings.ARBITRARY_EMAIL, password:self.fPassword.text!) { success in
                if (!success) {
                    DoAlert(title: "error", body: "Could not create account, contact support", vc: self)
                }
                else {
                    CurrentUser = Student();
                    CurrentUser.id = newUserName
                    CurrentUser.SetFirstName(newFirstName: self.fFirstName.text!)
                    CurrentUser.SetLastName(newLastName: self.fLastName.text!)
                    //userNameAlert(vc: self)
                    self.performSegue(withIdentifier:"studentCreateToHome", sender: self)

                }
            }
        }
    }
    
    @IBAction func signUpParentCodePressed(_ sender: Any) {
        Student(givenCode:fParentCode.text!) { res in
            if (res.firstName == "") {
                DoAlert(title: "error", body: "code not found, or student already registered", vc: self)
                return
            }
            
            CurrentUser = res
            
            UserHelper.GenerateUserName(firstName:res.firstName ?? "", lastName:res.lastName ?? "", type: "Student") { id in
                CurrentUser.id = "s_"+id
                CurrentUser.SetBio(newBio:res.bio ?? "")
                CurrentUser.SetEmail(newEmail: res.email ?? "")
                (CurrentUser as! Student).SetClassroom(newClass: res.classID ?? "")
                CurrentUser.SetFirstName(newFirstName: res.firstName ?? "")
                CurrentUser.SetLastName(newLastName: res.lastName ?? "")
                (CurrentUser as! Student).SetGPA(newGPA: (res as Student).gpa ?? 0.0)
                CurrentUser.SetPhotoPath(newPhotoPath: res.photoPath ?? "")
                CurrentUser.SetPronouns(newPronouns: res.pronouns ?? "")
                CurrentUser.Listen()
                DatabaseHelper.DeleteDocument(collectionName: Strings.STUDENT, documentName: self.fParentCode.text!)
                //userNameAlert(vc: self)
                self.performSegue(withIdentifier:"studentCreateToHome", sender: self)
            }
        }
    }
}
