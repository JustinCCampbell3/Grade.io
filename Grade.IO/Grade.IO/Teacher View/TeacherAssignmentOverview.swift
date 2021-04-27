//
//  TeacherAssignmentOverview.swift
//  Grade.IO
//
//  Created by user183573 on 2/23/21.
//

import UIKit

class TeacherAssignmentOverview: UIViewController {

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
    
    //the label above the scroll view
    @IBOutlet weak var gradeTotTimeHeader: UILabel!
    
    //var to access variables in the TeacherAssignmentPage
    var teacherAssignmentClicked = TeacherAssignmentPage()
    
    //array to hold the list of assignments
    var listAssigns: [Assignment] = []
    
    //var to hold the assignment we want
    var assignment: Assignment!
    
    var assignIndex: Int = 0
    
    //array for students
    var studentList: [Student] = []
    
    //view array
    var viewArray:[UIView] = []
    
    //section for scroll view of students' grade and total time
    //scroll view to hold everything
    lazy var scrollView: UIScrollView! = {
        let view = UIScrollView(frame: CGRect(x: 0, y: (gradeTotTimeHeader.frame.origin.y)  + (gradeTotTimeHeader.frame.height * 2), width: self.view.frame.width, height: self.view.frame.height))
        //view.contentSize = contentViewSize
        view.autoresizingMask = .flexibleHeight
        view.bounces = true
        view.showsHorizontalScrollIndicator = true
        return view
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("the assignIndex we got: ", assignIndex)
        
        //to get the assignment we need and then to do what we need to do
        currentClassroom.GetStudentObjects { (students) in
            self.getStudentList(students: students)
            
            currentClassroom.GetAssignmentObjects() { (res) in
                self.getAssignment(assignArray: res)
                self.populateAssignPageLabels()
                
            }
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
    
    //get all students in an array
    private func getStudentList(students: [Student]){
        for i in students {
            studentList.append(i)
        }
    }
    
    //using the assignment to populate the necessary labels
    private func populateAssignPageLabels(){
        
        assignName.text = assignment.name
        assignFileName.text = assignment.filePath
        assignInstructions.text = assignment.description
        assignAvgTime.text = String(assignment.GetAverageTime()) + " min"
        
        makeScrollView()
    }
    
    private func makeScrollView(){
        
        //size of the content needed
        var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.size.height)
        
        //var that will hold the new size of the height
        var newHeight = CGFloat(0)
        
        //add a UIView for all the assignments we have
        for i in 0..<studentList.count{
            print("in for loop where i is: ", i)
            var multiplier = CGFloat(i)
            if(i == 1){
                multiplier = 150
            }
            else if(i > 1){
                multiplier = (CGFloat(i)*100) + (50 * CGFloat(i))
            }
            
            
            print("y is: ", multiplier)
            let containerView: UIView = {
                let view = UIView(frame: CGRect(x: 0, y: multiplier, width: self.view.frame.width, height: 100))
                //this is the color of the scroll view background, not the actual full container
                view.backgroundColor = .white
                //view.frame.size = contentViewSize
                return view
            }()
            viewArray.append(containerView)
            print("i is: ", i)
            newHeight = multiplier
        }
        print("newHeight: ", newHeight)
        
        if(newHeight > CGFloat(self.view.frame.size.height)){
            contentViewSize = CGSize(width: self.view.frame.width, height: newHeight + 350) //100 height + 150 in between of stuff
            print("newHeight is larger than the current frame size")
        }
        scrollView.contentSize = contentViewSize
        
        //all scroll view stuff down here
        scrollView.layoutIfNeeded()
        scrollView.isScrollEnabled = true
        
        view.addSubview(scrollView)
        
        //keep track of the current index
        var curIndex = 0
        
        //put the info necessary within the assignment views
        for i in viewArray {
            
            scrollView.addSubview(i)
            
            //if the assignment was completed, then populate the questions of the assignment into a scroll view
            let resultIndex = assignment.GetResultIndexByID(id: studentList[curIndex].id!) //get the index of the current student's assignment results
            print("resultIndex: ", resultIndex)
            
            //for all the things we need to populate the scroll view with
            let sName = studentList[curIndex].firstName! + " " + studentList[curIndex].lastName!
            var sGrade = "N/A"
            var sOverallTime = "N/A"
            
            //resultIndex will be -1 if the student hasn't completed it yet
            if(resultIndex != -1){
                
                //get the result of the student for the assignment
                let studentResult = assignment.results?[resultIndex]
                let assignSubmitted = studentResult!.IsSubmitted //get whether the student has submitted their assignment
                
                if(assignSubmitted){
                    sGrade = String(studentResult!.Grade)
                    
                    //add up all the times for the overall time for the student
                    var totTime: Double = 0.0
                    
                    var timeInt: [TimeInterval] = studentResult!.TimeTakenPerQuestion!
                    
                    var tIndex = 0
                    for i in timeInt{
                        totTime += timeInt[tIndex]
                        tIndex+=1
                    }
                    
                    sOverallTime = String(totTime)
                }
            }

            //making label here makes sure each view has their own label
            //label for assignment name
            let nameLabel: UILabel = {
                let label = UILabel()
                label.text = sName
                return label
            }()
            i.addSubview(nameLabel)
            nameLabel.left(to: i, offset: 30)
            nameLabel.top(to: i, offset: (i.frame.height/4))
            
            //label for student's answer to the question
            let gradeLabel: UILabel = {
                let label = UILabel()
                label.text = sGrade
                return label
            }()
            i.addSubview(gradeLabel)
            gradeLabel.left(to: i, offset: 30)
            gradeLabel.top(to: i, offset: (i.frame.height/2) - nameLabel.frame.height) //halfway down the view
            
            //label for question specific time it took
            let questMetricLabel:UILabel = {
                let label = UILabel()
                label.text = sOverallTime
                return label
            }()
            i.addSubview(questMetricLabel)
            questMetricLabel.right(to: i, offset: -60)
            questMetricLabel.top(to: i, offset: (i.frame.height/8)-nameLabel.frame.height) //quarter down the view on the right
            
            curIndex+=1
        }
    }

}
