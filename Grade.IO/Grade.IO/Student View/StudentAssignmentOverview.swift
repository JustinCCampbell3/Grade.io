//
//  TeacherAssignmentOverview.swift
//  Grade.IO
//
//  Created by user183573 on 2/23/21.
//

import UIKit

class StudentAssignmentOverview: UIViewController {

    //label for name of assignment
    @IBOutlet weak var assignName: UILabel!
    
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
    var listAssigns: [Assignment] = []
    
    //var to hold the assignment we want
    var assignment: Assignment!
    
    var assignIndex: Int = 0
    
    //section for scroll view of students' grade and total time
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("the assignIndex we got: ", assignIndex)
        
        //to get the assignment we need and then to do what we need to do
        /*DatabaseHelper.GetAssignmentsFromClassID(classID: "testClass") { (res) in
            self.getAssignment(assignArray: res)
            self.populateAssignPageLabels()
        }*/
        
        currentClassroom.GetAssignmentObjects { (res) in
            self.getAssignment(assignArray: res)
            self.populateAssignPageLabels()
        }
        
        
        
    }

    //getting the assignment we need
    private func getAssignment(assignArray: [Assignment]){
        for i in assignArray{
            listAssigns.append(i)
        }
        assignment = assignArray[assignIndex]
        print("assignment name after get: ", assignment.name!)
    }
    
    //using the assignment to populate the necessary labels
    private func populateAssignPageLabels(){
        
        assignName.text = assignment.name
        //assignFileName.text = assignment.filePath
        assignInstructions.text = assignment.description
        assignAvgTime.text = String(assignment.GetAverageTime()) + " min"
    }

}
