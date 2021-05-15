//
//  AddStudentController.swift
//  Grade.IO
//
//  Created by user183542 on 5/14/21.
//

import Foundation
import UIKit

public class AddStudentPopupController:UIViewController
{
    @IBOutlet weak var FirstNameText: UITextField!
    @IBOutlet weak var LastNameText: UITextView!
    @IBOutlet weak var ParentEmailText: UITextView!
    
    @IBOutlet weak var SubmitPressed: UIButton!
    
    @IBAction func SubmitPressed(_ sender: Any) {
        if (FirstNameText.text != nil) {
            DatabaseHelper.GetStudentFromID(studentID: FirstNameText.text!) { res in
                res.SetClassroom(newClass: currentClassroom.id!)
                currentClassroom.AddStudent(newStudent: self.FirstNameText.text!)
            }
        }
    }
}
