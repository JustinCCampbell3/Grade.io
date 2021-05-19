//
//  TeacherAssignmentOverview.swift
//  Grade.IO
//
//  Created by user183573 on 2/23/21.
//

import UIKit
import TinyConstraints
import Foundation

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
    @IBOutlet weak var assignQuestLabel: UILabel!
    
    //button to start assignment
    @IBOutlet weak var startButton: UIButton!
    
    //grade for the assignment
    @IBOutlet weak var assignGrade: UILabel!
    
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
        let view = UIScrollView(frame: CGRect(x: 0, y: (assignQuestLabel.frame.origin.y)  + (assignQuestLabel.frame.height) + 30, width: self.view.frame.width, height: self.view.frame.height - assignQuestLabel.frame.height))
        //view.contentSize = contentViewSize
        view.autoresizingMask = .flexibleHeight
        view.bounces = true
        view.showsHorizontalScrollIndicator = true
        return view
    }()
    
    //var that will hold the assignment questions
    var listQuestions: [Problem] = []
    
    //var that will hold a student's answers to the specific assignment
    var studentAns: [String] = []
    
    //var that will hold the student's metrics (time) for each question
    var questMetrics: [TimeInterval] = []
    
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
    //get the student's answers to the problems
    private func getStudentAns(result: Result){
        for i in result.StudentAnswers!{
            studentAns.append(i)
        }
    }
    
    //get an array of the question metrics
    private func getQuestionMetrics(assign: Assignment){
        let resultInd = assign.GetResultIndexByID(id: CurrentUser.id!)
        let result = assign.results![resultInd]
        questMetrics = result.TimeTakenPerQuestion!
    }
    
    //using the assignment to populate the necessary labels
    private func populateAssignPageLabels(){
        startButton.isHidden = false
        assignQuestLabel.isHidden = true
        //assignGrade.isHidden = true
        
        assignName.text = assignment.name
        //assignFileName.text = assignment.filePath
        assignInstructions.text = assignment.description
        assignAvgTime.text = "N/A"
        
        //if the assignment was completed, then populate the questions of the assignment into a scroll view
        let resultIndex = assignment.GetResultIndexByID(id: CurrentUser.id!) //get the index of the current student's assignment results
        print("current user: ", CurrentUser.id!)
        print("resultIndex: ", resultIndex)
        
        //resultIndex will be -1 if the student hasn't completed it yet
        if(resultIndex != -1){
            //hide the start assignment button
            startButton.isHidden = true
            //unhide the questions thing
            assignQuestLabel.isHidden = false
            
            //get the result of the student for the assignment
            let studentResult = assignment.results?[resultIndex]
            let assignSubmitted = studentResult!.IsSubmitted //get whether the student has submitted their assignment
            //if the user has submitted the assignment
            if(assignSubmitted){
                //can now set the average time
                //assignAvgTime.text = studentResult?.stringFromTimeInterval(interval: studentResult!.TimeTaken)
                //unhide and put in the grade
                //assignGrade.isHidden = false
                let percentGrade = studentResult!.Grade * 100.0
                assignGrade.text = String(format: "%.2f", percentGrade) + "%"
                
                //get all of the problems on the assignment
                getAssignProblems(assign: assignment)
                
                //get all of the current student's answers to those problems
                getStudentAns(result: studentResult!)
                
                //get the question metrics
                getQuestionMetrics(assign: assignment)
                
                var totalTime: Double = 0
                for j in questMetrics{
                    print("result time per question: ", j)
                    totalTime += j
                }
                assignAvgTime.text = String(format: "%.2f", totalTime) + "secs"
                
                //make a scroll view for the questions and answers
                makeScrollView(sResult: studentResult!)
            }
        }
        
    }
    
    private func makeScrollView(sResult: Result){
        
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
                label.text = "Question " + String(curIndex) + ": " + listQuestions[curIndex].Question
                return label
            }()
            i.addSubview(questionLabel)
            questionLabel.left(to: i, offset: 30)
            questionLabel.top(to: i, offset: (i.frame.height/8))
            
            print("answer from result: " + sResult.StudentAnswers![curIndex])
            
            //label for student's answer to the question
            let sAnswerLabel: UILabel = {
                let label = UILabel()
                label.text = "Student Answer: " + sResult.StudentAnswers![curIndex]
                return label
            }()
            i.addSubview(sAnswerLabel)
            sAnswerLabel.left(to: i, offset: 30)
            sAnswerLabel.top(to: i, offset: (i.frame.height/2.75) - questionLabel.frame.height) //halfway down the view
            
            //label for Actual answer to the question
            let actAnswerLabel: UILabel = {
                let label = UILabel()
                label.text = "Correct Answer: " + listQuestions[curIndex].Answer
                return label
            }()
            i.addSubview(actAnswerLabel)
            actAnswerLabel.left(to: i, offset: 30)
            actAnswerLabel.top(to: i, offset: (i.frame.height/1.75) - questionLabel.frame.height) //halfway down the view
            
            
            //label for question specific time it took
            let questMetricLabel:UILabel = {
                let label = UILabel()
                label.text = String(format: "%.2f", questMetrics[curIndex]) + "secs"
                return label
            }()
            i.addSubview(questMetricLabel)
            questMetricLabel.right(to: i, offset: -60)
            questMetricLabel.top(to: i, offset: (i.frame.height/8)-questionLabel.frame.height) //quarter down the view on the right
            
            curIndex+=1
        }
    }

}
