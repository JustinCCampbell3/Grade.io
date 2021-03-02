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
    
    //label for due date
    @IBOutlet weak var assignDueDate: UILabel!
    
    //label for file name
    @IBOutlet weak var assignFileName: UILabel!
    
    //label for total average time
    @IBOutlet weak var assignAvgTime: UILabel!
    
    //label for instructions
    @IBOutlet weak var assignInstructions: UILabel!
    
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
        
    }
    


}
