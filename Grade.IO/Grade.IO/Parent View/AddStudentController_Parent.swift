//
//  AddStudentController.swift
//  Grade.IO
//
//  Created by user183542 on 5/15/21.
//

import Foundation
import UIKit

public class AddStudentController:UIViewController
{
    @IBOutlet weak var ChildCode: UITextField!
    @IBAction func ConfirmPressed(_ sender: Any) {
        (CurrentUser as! Parent).AddStudent(newStudent: ChildCode.text!)
    }
}
