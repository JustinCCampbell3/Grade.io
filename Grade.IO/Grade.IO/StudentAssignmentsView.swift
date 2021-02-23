//
//  StudentAssignmentsView.swift
//  Grade.IO
//
//  Created by user183573 on 2/3/21.
//

import UIKit

class StudentAssignmentsView: UIViewController {

    //array of views
    var todoViewArray:[UIView] = []
    //array of completed views
    var completeViewArray:[UIView] = []
    
    //UILabel for ToDo
    @IBOutlet weak var todoLabel: UILabel!
    //UILabel for Completed
    @IBOutlet weak var completeLabel: UILabel!

    //scroll view to hold all assignments that still need to be done
    @IBOutlet lazy var todoScrollView: UIScrollView! = {
        let view = UIScrollView(frame: CGRect(x: 0, y: (todoLabel.frame.origin.y + todoLabel.frame.height + 8), width: self.view.frame.width, height: 315))
        //view.contentSize = contentViewSize
        view.autoresizingMask = .flexibleHeight
        view.bounces = true
        view.showsHorizontalScrollIndicator = true
        return view
    }()
    
    //scroll view to hold all assignments that still need to be done
    @IBOutlet lazy var completeScrollView: UIScrollView! = {
        let view = UIScrollView(frame: CGRect(x: 0, y: (completeLabel.frame.origin.y + completeLabel.frame.height + 8), width: self.view.frame.width, height: self.view.frame.height))
        //view.contentSize = contentViewSize
        view.autoresizingMask = .flexibleHeight
        view.bounces = true
        view.showsHorizontalScrollIndicator = true
        return view
    }()
    
    //var that will hold the assignments
    var todoAssignments: [Assignment] = []
    //second var to hold assignments
    var completeAssignments: [Assignment] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //create a scroll view based on the number of assignments we have
        //may have to change testClass to myClass later
        DatabaseHelper.GetAssignmentsFromClassID(classID: "testClass") { (res) in
            self.makeTodoScrollView(newList: res)
            self.makeCompleteScrollView(newList: res)
        }
    }
    
    //change listAssignments to have all the assignments
    private func getTodoAssignmentList(assignments: [Assignment]){
        for i in assignments {
            todoAssignments.append(i)
        }
    }
    
    //change completeAssignments to have all assignments
    private func getCompleteAssignmentList(assignments: [Assignment]){
        for i in assignments {
            completeAssignments.append(i)
        }
    }
    
    private func makeTodoScrollView(newList: [Assignment]){
        //make a list of assignments
        self.getTodoAssignmentList(assignments: newList)
        
        //size of the content needed
        var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.size.height)
        
        //var that will hold the new size of the height
        var newHeight = CGFloat(0)
        
        //add a UIView for all the assignments we have
        for i in 0..<todoAssignments.count{
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
            todoViewArray.append(containerView)
            print("i is: ", i)
            newHeight = multiplier
        }
        print("newHeight: ", newHeight)
        
        if(newHeight > CGFloat(self.view.frame.size.height)){
            contentViewSize = CGSize(width: self.view.frame.width, height: newHeight + 350) //100 height + 150 in between of stuff
            print("newHeight is larger than the current frame size")
        }
        todoScrollView.contentSize = contentViewSize
        
        //all scroll view stuff down here
        todoScrollView.layoutIfNeeded()
        todoScrollView.isScrollEnabled = true
        
        view.addSubview(todoScrollView)
        
        //keep track of the current index
        var curIndex = 0
        
        //put the info necessary within the assignment views
        for i in todoViewArray {
            todoScrollView.addSubview(i)

            //making label here makes sure each view has their own label
            //label for assignment name
            let nameLabel: UILabel = {
                let label = UILabel()
                label.text = todoAssignments[curIndex].name
                return label
            }()
            i.addSubview(nameLabel)
            nameLabel.left(to: i, offset: 30)
            nameLabel.top(to: i, offset: (i.frame.height/4)-nameLabel.frame.height)
            
            //section for changing date to string
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yy"
            //print("before date: ", todoAssignments[curIndex].dueDate!)
            //print("Date: ", dateFormatter.string(from: listAssignments[curIndex].dueDate!))
            
            //label for due date
            let dueDateLabel: UILabel = {
                let label = UILabel()
                label.text = "Date"
                return label
            }()
            i.addSubview(dueDateLabel)
            dueDateLabel.left(to: i, offset: 30)
            dueDateLabel.top(to: i, offset: (i.frame.height/2)-nameLabel.frame.height) //halfway down the view
            
            
            
            //lines that allow the view to be tapped
            let gesture = UITapGestureRecognizer(target: self, action: #selector(self.sendToAssignment(_sender:)))
            i.addGestureRecognizer(gesture)
            
            curIndex+=1
        }
    }
    
    private func makeCompleteScrollView(newList: [Assignment]){
        //make a list of assignments
        self.getCompleteAssignmentList(assignments: newList)
        
        //size of the content needed
        var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.size.height)
        
        //var that will hold the new size of the height
        var newHeight = CGFloat(0)
        
        //add a UIView for all the assignments we have
        for i in 0..<completeAssignments.count{
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
            completeViewArray.append(containerView)
            print("i is: ", i)
            newHeight = multiplier
        }
        print("newHeight: ", newHeight)
        
        if(newHeight > CGFloat(self.view.frame.size.height)){
            contentViewSize = CGSize(width: self.view.frame.width, height: newHeight + 350) //100 height + 150 in between of stuff
            print("newHeight is larger than the current frame size")
        }
        completeScrollView.contentSize = contentViewSize
        
        //all scroll view stuff down here
        completeScrollView.layoutIfNeeded()
        completeScrollView.isScrollEnabled = true
        
        view.addSubview(completeScrollView)
        
        //keep track of the current index
        var index = 0
        
        //put the info necessary within the assignment views
        for i in completeViewArray {
            completeScrollView.addSubview(i)

            //making label here makes sure each view has their own label
            //label for assignment name
            let nameLabel: UILabel = {
                let label = UILabel()
                label.text = completeAssignments[index].name
                return label
            }()
            i.addSubview(nameLabel)
            nameLabel.left(to: i, offset: 30)
            nameLabel.top(to: i, offset: (i.frame.height/4)-nameLabel.frame.height)
            
            //section for changing date to string
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yy"
            //print("before date: ", completeAssignments[curIndex].dueDate!)
            //print("Date: ", dateFormatter.string(from: listAssignments[curIndex].dueDate!))
            
            //label for due date
            let dueDateLabel: UILabel = {
                let label = UILabel()
                label.text = "Date"
                return label
            }()
            i.addSubview(dueDateLabel)
            dueDateLabel.left(to: i, offset: 30)
            dueDateLabel.top(to: i, offset: (i.frame.height/2)-nameLabel.frame.height) //halfway down the view
            
            
            
            //lines that allow the view to be tapped
            let gesture = UITapGestureRecognizer(target: self, action: #selector(self.sendToAssignment(_sender:)))
            i.addGestureRecognizer(gesture)
            
           index+=1
        }
    }
    
    //send the user to the assignment page when they click a UIView
    @objc func sendToAssignment(_sender:UITapGestureRecognizer){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: UIViewController = storyBoard.instantiateViewController(withIdentifier: "TAssignSpec") as! UIViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated:true, completion: nil)
    }
    
}
