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
    @IBOutlet weak var StudentIDText: UITextField!
    
    @IBOutlet weak var SubmitPressed: UIButton!
    
    @IBAction func SubmitPressed(_ sender: Any) {
        if (StudentIDText.text != nil) {
            DatabaseHelper.GetStudentFromID(studentID: StudentIDText.text!) { res in
                res.SetClassroom(newClass: currentClassroom.id!)
                currentClassroom.AddStudent(newStudent: self.StudentIDText.text!)
            }
        }
        //refresh the page
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let curVC = storyboard.instantiateViewController(withIdentifier: "TSLNav") as! UINavigationController
        //let vc: UIViewController = storyBoard.instantiateViewController(withIdentifier: "TAccount") as! UIViewController
        curVC.modalPresentationStyle = .fullScreen
        self.present(curVC, animated:true, completion: nil)
    }
}
