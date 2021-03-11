//
//  StudentAccount.swift
//  Grade.IO
//
//  Created by user183573 on 3/8/21.
//

import UIKit

class StudentAccount: UIViewController {
    //first name of student
    @IBOutlet weak var firstName: UILabel!
    //last name of student
    @IBOutlet weak var lastName: UILabel!
    //student bio
    @IBOutlet weak var bio: UILabel!
    //preferred pronouns
    @IBOutlet weak var pronouns: UILabel!
    //Parent First name
    @IBOutlet weak var pName: UILabel!
    //parent last name
    //@IBOutlet weak var pLastName: UILabel!
    //parent email
    @IBOutlet weak var pEmail: UILabel!
    //parent phone number
    @IBOutlet weak var pNumber: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserHelper.GetStudentByID(id: CurrentUser.id!) { (stu) in
            self.popStudentAccount(student: stu)
            /*UserHelper.GetParentByID(id: stu.parentID!) { (par) in
                self.popStudentAccount(student: stu, parent: par)
            }*/
        }
    }
    
    private func popStudentAccount(student: Student){
        firstName.text = student.firstName
        lastName.text = student.lastName
        bio.text = student.bio
        pronouns.text = student.pronouns
        
        //pName.text = parent.firstName! + " " + parent.lastName!
        //pEmail.text = parent.email
        //pNumber.text = parent.phoneNumber
        
    }

}
