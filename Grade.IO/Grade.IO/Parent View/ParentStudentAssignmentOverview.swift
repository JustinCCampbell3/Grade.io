//
//  ParentStudentAssignmentOverview.swift
//  Grade.IO
//
//  Created by user183573 on 4/3/21.
//

import UIKit

class ParentStudentAssignmentOverview: UIViewController {

    @IBOutlet weak var assignName: UILabel!
    @IBOutlet weak var grade: UILabel!
    @IBOutlet weak var dueDate: UILabel!
    @IBOutlet weak var instructions: UILabel!
    @IBOutlet weak var overallAvgTime: UILabel!
    @IBOutlet weak var assignQuestions: UILabel!
    
    //array of views
    var viewArray:[UIView] = []
    
    //array to hold the list of assignments
    var listAssigns: [Assignment] = []
    
    //var to hold the assignment we want
    var assignment: Assignment!
    
    var assignIndex: Int = 0
    
    //section for scroll view of students' grade and total time
    //scroll view to hold everything
    lazy var scrollView: UIScrollView! = {
        let view = UIScrollView(frame: CGRect(x: 0, y: (assignQuestions.frame.origin.y)  + (assignQuestions.frame.height) + 30, width: self.view.frame.width, height: self.view.frame.height))
        //view.contentSize = contentViewSize
        view.autoresizingMask = .flexibleHeight
        view.bounces = true
        view.showsHorizontalScrollIndicator = true
        return view
    }()
    
    //var that will hold the assignment questions
    var listQuestions: [Problem] = []
    
    //var that will hold a student's answers to the specific assignment
    
    
    //var that will hold the student's metrics (time) for each question
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //need to see the student's questions and responses
        
    }
    
    //getting the assignment we need
    private func getAssignment(assignArray: [Assignment]){
        for i in assignArray{
            listAssigns.append(i)
        }
        assignment = assignArray[assignIndex]
        print("assignment name after get: ", assignment.name!)
    }
    
    //getting the problems
    private func getAssignProblems(assign: Assignment){
        for i in assign.problems!{
            listQuestions.append(i)
        }
    }
    
    private func populateLabels(){
        assignName.text = assignment.name
        instructions.text = assignment.description
        //grade for the specific student
        //due date for the assignment
        //overall average time for assignment for specific student
    }
    
    
    
}
