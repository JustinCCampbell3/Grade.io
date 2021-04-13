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
    
    //for the questions label on only the completed assignment page
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
    
    //getting the problems
    private func getAssignProblems(assign: Assignment){
        for i in assign.problems!{
            listQuestions.append(i)
        }
    }
    
    //using the assignment to populate the necessary labels
    private func populateAssignPageLabels(){
        
        assignName.text = assignment.name
        //assignFileName.text = assignment.filePath
        assignInstructions.text = assignment.description
        assignAvgTime.text = String(assignment.GetAverageTime()) + " min"
        
        //if the assignment was completed, then populate the questions of the assignment into a scroll view
        let resultIndex = assignment.GetResultIndexByID(id: CurrentUser.id!) //get the index of the current student's assignment results
        let assignSubmitted = assignment.results?[resultIndex].IsSubmitted //get whether the student has submitted their assignment
        //if the user has submitted the assignment
        if(assignSubmitted!){
            //get all of the problems on the assignment
            getAssignProblems(assign: assignment)
            
            //get all of the current student's answers to those problems
            
            //display both of them in the scroll view
        }
        
    }
    
    private func makeScrollView(newList: [Problem], studentAns: [Result]){
        
        //size of the content needed
        var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.size.height)
        
        //var that will hold the new size of the height
        var newHeight = CGFloat(0)
        
        //add a UIView for all the assignments we have
        for i in 0..<listQuestions.count{
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

            //making label here makes sure each view has their own label
            //label for assignment name
            let questionLabel: UILabel = {
                let label = UILabel()
                label.text = listQuestions[curIndex].Question
                return label
            }()
            i.addSubview(questionLabel)
            questionLabel.left(to: i, offset: 30)
            questionLabel.top(to: i, offset: (i.frame.height/4)-questionLabel.frame.height)
            
            //section for changing date to string
            //let dateFormatter = DateFormatter()
            //dateFormatter.dateFormat = "MM/dd/yy"
            //print("before date: ", listAssignments[curIndex].dueDate!)
            //print("Date: ", dateFormatter.string(from: listAssignments[curIndex].dueDate!))
            
            //label for student's answer to the question
            let sAnswerLabel: UILabel = {
                let label = UILabel()
                label.text = "Student Answer: "
                return label
            }()
            i.addSubview(sAnswerLabel)
            sAnswerLabel.left(to: i, offset: 30)
            sAnswerLabel.top(to: i, offset: (i.frame.height/2)-questionLabel.frame.height) //halfway down the view
            
            //label for Actual answer to the question
            let actAnswerLabel: UILabel = {
                let label = UILabel()
                label.text = "Correct Answer: " + listQuestions[curIndex].Question
                return label
            }()
            i.addSubview(actAnswerLabel)
            actAnswerLabel.left(to: i, offset: 30)
            actAnswerLabel.top(to: i, offset: (i.frame.height/2)-questionLabel.frame.height) //halfway down the view
            
            curIndex+=1
        }
    }

}
