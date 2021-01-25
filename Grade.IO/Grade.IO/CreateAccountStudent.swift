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
                    CurrentUser.ID = newUserName
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
            if (res.FirstName == "") {
                DoAlert(title: "error", body: "code not found, or student already registered", vc: self)
                return
            }
            
            CurrentUser = res
            
            UserHelper.GenerateUserName(firstName:res.FirstName, lastName:res.LastName, type: "Student") { id in
                CurrentUser.ID = "s_"+id
                CurrentUser.SetBio(newBio:res.Bio)
                CurrentUser.SetEmail(newEmail: res.Email)
                (CurrentUser as! Student).SetClassroom(newClass: res.ClassID)
                CurrentUser.SetFirstName(newFirstName: res.FirstName)
                CurrentUser.SetLastName(newLastName: res.LastName)
                CurrentUser.SetBio(newBio: res.Bio)
                (CurrentUser as! Student).SetGPA(newGPA: (res as Student).GPA)
                CurrentUser.SetPhotoPath(newPhotoPath: res.PhotoPath)
                CurrentUser.SetPronouns(newPronouns: res.Pronouns)
                CurrentUser.Listen()
                DatabaseHelper.DeleteDocument(collectionName: Strings.STUDENT, documentName: self.fParentCode.text!)
                //userNameAlert(vc: self)
                self.performSegue(withIdentifier:"studentCreateToHome", sender: self)

            }
        }
    }
}
