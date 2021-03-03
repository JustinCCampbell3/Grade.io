//
//  TeacherOverviewStudentList.swift
//  Grade.IO
//
//  Created by user183573 on 3/2/21.
//

import UIKit

class TeacherOverviewStudentList: UIViewController {

    //label for student's first name
    @IBOutlet weak var firstName: UILabel!
    
    //label for student's last name
    @IBOutlet weak var lastName: UILabel!
    
    //label for student's pronouns
    @IBOutlet weak var pronouns: UILabel!
    
    //label for contact's name
    @IBOutlet weak var contactName: UILabel!
    
    //label for contact's email
    @IBOutlet weak var contactEmail: UILabel!
    
    //label for contact's number
    @IBOutlet weak var contactNumber: UILabel!
    
    //label for grade percentage
    @IBOutlet weak var gradePercent: UILabel!
    
    //label for grade letter
    @IBOutlet weak var gradeLetter: UILabel!
    
    //var to access variables in the TeacherAssignmentPage
    var teacherAssignmentClicked = TeacherAssignmentPage()
    
    //array to hold the list of assignments
    var studentList: [Student] = []
    
    //var to hold the assignment we want
    var student: Student!
    
    var studentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("student index gotten is: ", studentIndex);
        
        //call the classroom function to get students
        currentClassroom.GetStudentObjects { (res) in
            self.getStudentList(students: res)
            self.populateStudentLabels()
        }
        
        
    }
    
    //change listAssignments to have all the assignments
    private func getStudentList(students: [Student]){
        for i in students {
            studentList.append(i)
        }
        student = studentList[studentIndex]
    }
    
    private func populateStudentLabels(){
        firstName.text = student.firstName
        lastName.text = student.lastName
        pronouns.text = student.pronouns
        //gradePercent.text = String(student.gpa!)
        //get student's parent
        UserHelper.GetUserByID(id: student.parentID!) { (res) in
            self.popStudentParent(parent: (res as! Parent))
        }
        
        
        
        
    }
    
    private func popStudentParent(parent: Parent){
        contactName.text = parent.firstName! + " " + parent.lastName!
        contactEmail.text = parent.email
        contactNumber.text = parent.phoneNumber
    }


}
