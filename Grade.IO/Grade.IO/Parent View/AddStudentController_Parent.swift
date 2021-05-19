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
    @IBOutlet weak var ConfirmPressed: UIButton!
    
    @IBAction func ConfirmPressed(_ sender: Any) {
        (CurrentUser as! Parent).AddStudent(newStudent: ChildCode.text!)
        //reload the page
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let curVC = storyboard.instantiateViewController(withIdentifier: "PHNav") as! UINavigationController
        //let vc: UIViewController = storyBoard.instantiateViewController(withIdentifier: "TAccount") as! UIViewController
        curVC.modalPresentationStyle = .fullScreen
        self.present(curVC, animated:true, completion: nil)
        
    }
}
