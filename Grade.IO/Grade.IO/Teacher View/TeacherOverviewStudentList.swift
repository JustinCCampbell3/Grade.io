//
//  TeacherOverviewStudentList.swift
//  Grade.IO
//
//  Created by user183573 on 3/2/21.
//

import UIKit
import TinyConstraints
import Foundation

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
    
    //label that says assignments
    @IBOutlet weak var assignLabel: UILabel!
    
    //var to access variables in the TeacherAssignmentPage
    //var teacherAssignmentClicked = TeacherAssignmentPage()
    
    //array to hold the list of assignments
    var studentList: [Student] = []
    
    //var to hold the assignment we want
    var student: Student!
    
    var studentIndex: Int = 0
    
    //scroll view to hold everything
    lazy var scrollView: UIScrollView! = {
        let view = UIScrollView(frame: CGRect(x: 0, y: (assignLabel.frame.origin.y)  + (assignLabel.frame.height) + 30, width: self.view.frame.width, height: self.view.frame.height - assignLabel.frame.origin.y))
        //view.contentSize = contentViewSize
        view.autoresizingMask = .flexibleHeight
        view.bounces = true
        view.showsHorizontalScrollIndicator = true
        return view
    }()
    
    //var that will hold the assignments
    var listAssignments: [Assignment] = []
    
    //variable to hold assignment array index that was clicked
    var clickedAssignment: Int = 0
    
    var curAssign: Assignment!
    
    //array of views
    var viewArray:[UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("student index gotten is: ", studentIndex);
        
        //call the classroom function to get students
        currentClassroom.GetAssignmentObjects { (assigns) in
            self.getAssignments(assignArray: assigns)
            
            currentClassroom.GetStudentObjects { (res) in
                self.getStudentList(students: res)
                self.populateStudentLabels()
                
            }
        }
    }
    
    //change listAssignments to have all the assignments
    private func getStudentList(students: [Student]){
        for i in students {
            studentList.append(i)
        }
        student = studentList[studentIndex]
    }
    
    //getting the assignment we need
    private func getAssignments(assignArray: [Assignment]){
        for i in assignArray{
            listAssignments.append(i)
        }
    }
    
    private func populateStudentLabels(){
        firstName.text = self.student.firstName
        lastName.text = student.lastName
        pronouns.text = student.pronouns
        
        //for the grade
        self.findGrade()
        
        //somehow figure out if its nil
        //gradePercent.text = String(student.gpa!)
        makeScrollView()
        
        //make sure there is a parent id
        
        if(student.parentID != nil){
            //get student's parent
            UserHelper.GetUserByID(id: student.parentID!) { (res) in
                self.popStudentParent(parent: (res as! Parent))
            }
        }
        
        
    }
    
    private func findGrade(){

        var totalGrade: Float = 0
        var numAssignsTaken: Int = 0
        
        for i in listAssignments{
            let resultIndex = i.GetResultIndexByID(id: student.id!)
            
            if(resultIndex != -1){
                let studentResult = i.results?[resultIndex]
                let percent = studentResult!.Grade
                totalGrade += percent
                print("totalGrade now: ", totalGrade)
                numAssignsTaken += 1
            }
        }
        print("num of assigns taken: ", numAssignsTaken)
        
        let avgGrade = totalGrade / Float(numAssignsTaken)
        let percentGrade = avgGrade * 100.0
        
        gradePercent.text = String(format: "%.2f", percentGrade) + "%"
    }
    
    private func popStudentParent(parent: Parent){
        contactName.text = parent.firstName! + " " + parent.lastName!
        contactEmail.text = parent.email
        contactNumber.text = parent.phone
    }


    private func makeScrollView(){
        
        //size of the content needed
        var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.size.height)
        
        //var that will hold the new size of the height
        var newHeight = CGFloat(0)
        
        //add a UIView for all the assignments we have
        for i in 0..<listAssignments.count{
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
                
                //get the index of the current student's assignment results
                let resultIndex = listAssignments[i].GetResultIndexByID(id: student.id!)
                
                //check to make sure the result isn't -1, which means they haven't submitted
                print("resultIndex: ", resultIndex)
                if(resultIndex != -1){
                    //make the backgroun green if the user has completed it
                    
                    //make the background red if the assignment is overdue (need due date as string and actual date as a string)
                    //this is the color of the scroll view background, not the actual full container
                    
                    let studentResult = listAssignments[i].results?[resultIndex]
                    let assignSubmitted = studentResult!.IsSubmitted //get whether the student has submitted their assignment
                    
                    //white if the assignment hasn't been submitted but its before the due date
                    if(!assignSubmitted){
                        view.backgroundColor = .white
                    }
                    //red if the assignment hasn't been submitted and its late
                  /*  else if(i == 1){
                        view.backgroundColor = .init(red: 255/255.0, green: 78/255.0, blue: 78/255.0, alpha: 1)
                    } */
                    //green if the assignment has been submitted
                    else{
                        view.backgroundColor = .init(red: 120/255.0, green: 228/255.0, blue: 101/255.0, alpha: 1)
                    }
                }
                else{
                    view.backgroundColor = .white
                }

                return view
            }()
            viewArray.append(containerView)
            print("i is: ", i)
            newHeight = multiplier
        }
        print("newHeight: ", newHeight)
        print("CGFloat: ", CGFloat(self.view.frame.size.height))
        
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
            let nameLabel: UILabel = {
                let label = UILabel()
                label.text = listAssignments[curIndex].name
                return label
            }()
            i.addSubview(nameLabel)
            nameLabel.left(to: i, offset: 30)
            nameLabel.top(to: i, offset: (i.frame.height/4)-nameLabel.frame.height)
            
            //section for changing date to string
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yy"
            //print("before date: ", listAssignments[curIndex].dueDate!)
            //print("Date: ", dateFormatter.string(from: listAssignments[curIndex].dueDate!))
            
            //label for due date
            let dueDateLabel: UILabel = {
                let label = UILabel()
                label.text = "Date"
                return label
            }()
            i.addSubview(dueDateLabel)
            dueDateLabel.right(to: i, offset: -30)
            dueDateLabel.top(to: i, offset: (i.frame.height/4)-nameLabel.frame.height) //halfway down the view
            
            print("after date label")
            
            //get the index of the current student's assignment results
            let resultIndex = listAssignments[curIndex].GetResultIndexByID(id: student.id!)
            var sGrade = "N/A"
            
            if(resultIndex != -1){
                let studentResult = listAssignments[curIndex].results?[resultIndex]
                sGrade = String(studentResult!.Grade)
            }
            
            //label for grade the student got
            let gradeLabel: UILabel = {
                let label = UILabel()
                label.text = sGrade
                return label
            }()
            i.addSubview(gradeLabel)
            gradeLabel.left(to: i, offset: 30)
            gradeLabel.top(to: i, offset: (i.frame.height/2)-nameLabel.frame.height)
            
            //lines that allow the view to be tapped
            let gesture = TapGesture(target: self, action: #selector(self.sendToAssignment(_:)))
            gesture.givenIndex = curIndex
            i.addGestureRecognizer(gesture)
            
            
            curIndex+=1
        }
    }
    
    
    //send the user to the assignment page when they click a UIView
    @objc func sendToAssignment(_ sender:TapGesture) {
        clickedAssignment = sender.givenIndex
        
        print("Clicked assignment is: ", clickedAssignment)
        CurrentAssignment = listAssignments[clickedAssignment]
        //let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        //let vc = storyBoard.instantiateViewController(withIdentifier: "TAssignSpec") as! UIViewController
        let vc = storyboard?.instantiateViewController(identifier: "TStudentAssign") as! TeacherStudentAnswers
        //let vc = TeacherAssignmentOverview()
        
        //vc.modalPresentationStyle =
        vc.assignIndex = clickedAssignment
        vc.studentID = student.id!
        vc.modalPresentationStyle = .fullScreen
        //self.present(vc, animated:true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        //self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
