//
//  StudentAssignmentsView.swift
//  Grade.IO
//
//  Created by user183573 on 2/3/21.
//

import UIKit
import TinyConstraints
import Foundation

class StudentAssignmentsView: UIViewController {
    //array of views
    var viewArray:[UIView] = []
    
    
    //add assignment button that will be used for the upper boundary
    @IBOutlet var studentGrade: UILabel!
    

    //scroll view to hold everything
    lazy var scrollView: UIScrollView! = {
        let view = UIScrollView(frame: CGRect(x: 0, y: (studentGrade.frame.origin.y)  + (studentGrade.frame.height) + 30, width: self.view.frame.width, height: self.view.frame.height))
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //create a scroll view based on the number of assignments we have
        //may have to change testClass to myClass later
        currentClassroom.GetAssignmentObjects { (res) in
            //self.listAssignments = res
            self.makeScrollView(newList: res)
            
            
        }
        
    }
    
    //for the grade of the student
    private func popGrade(student: Student){
        
    }
    
    //change listAssignments to have all the assignments
    private func getAssignmentList(assignments: [Assignment]){
        for i in assignments {
            listAssignments.append(i)
        }
    }
    
    private func makeScrollView(newList: [Assignment]){
        //make a list of assignments
        self.getAssignmentList(assignments: newList)
        
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
                let resultIndex = listAssignments[i].GetResultIndexByID(id: CurrentUser.id!)
                
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
            
            //to hold results
            /*var results:[Result] = listAssignments[curIndex].results!
            
            //label for grade the student got
            let gradeLabel: UILabel = {
                let label = UILabel()
                label.text = String(results[curIndex].Grade)
                return label
            }()
            i.addSubview(nameLabel)
            gradeLabel.left(to: i, offset: -30)
            gradeLabel.top(to: i, offset: (i.frame.height/4)-nameLabel.frame.height)
            */
            
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
        let vc = storyboard?.instantiateViewController(identifier: "SAssignOviewPage") as! StudentAssignmentOverview
        //let vc = TeacherAssignmentOverview()
        
        //vc.modalPresentationStyle =
        vc.assignIndex = clickedAssignment
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated:true, completion: nil)
        //self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

