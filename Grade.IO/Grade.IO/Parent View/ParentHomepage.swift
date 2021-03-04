//
//  ParentHomepage.swift
//  Grade.IO
//
//  Created by user183573 on 3/3/21.
//

import UIKit

class ParentHomepage: UIViewController {
    //label for username
    @IBOutlet weak var username:UILabel!
    
    //add assignment button that will be used for the upper boundary
    @IBOutlet var addStudentBtn: UIButton!
    
    //array of views
    var viewArray:[UIView] = []

    //scroll view to hold everything
    lazy var scrollView: UIScrollView! = {
        let view = UIScrollView(frame: CGRect(x: 0, y: (addStudentBtn.frame.origin.y * 2)  + (addStudentBtn.frame.height), width: self.view.frame.width, height: self.view.frame.height))
        //view.contentSize = contentViewSize
        view.autoresizingMask = .flexibleHeight
        view.bounces = true
        view.showsHorizontalScrollIndicator = true
        return view
    }()
    
    //var that will hold the children (students)
    var listStudents: [Student] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set the username label
        username.text = CurrentUser.id
        print("parent's username is: ", CurrentUser.id)
        
        //get the parent by current user id
        /*UserHelper.GetParentByID(id: CurrentUser.id!) { (res) in
            //get the children from the current parent
            res.GetChildren { (children) in
                //go through and make the children pics and stuff
                self.getParentChildren(children: children)
            }
        }
        */
        
    }
    
    private func getStudentList(students: [Student]){
        for i in students {
            listStudents.append(i)
        }
    }
    
   /* private func getParentChildren(children: [Student]){
        //make a list of assignments
        self.getStudentList(students: children)
        
        //size of the content needed
        var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.size.height)
        
        //var that will hold the new size of the height
        var newHeight = CGFloat(0)
        
        //add a UIView for all the assignments we have
        for i in 0..<listStudents.count{
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
                let view = UIView(frame: CGRect(x: 0, y: multiplier, width: self.view.frame.width/2 , height: 200))
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
            contentViewSize = CGSize(width: self.view.frame.width, height: newHeight + 450) //100 height + 150 in between of stuff
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
                label.text = listStudents[curIndex].name
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
            dueDateLabel.left(to: i, offset: 30)
            dueDateLabel.top(to: i, offset: (i.frame.height/2)-nameLabel.frame.height) //halfway down the view
            
            
            
            //lines that allow the view to be tapped
            let gesture = TapGesture(target: self, action: #selector(self.sendToAssignment(_:)))
            gesture.givenIndex = curIndex
            i.addGestureRecognizer(gesture)
            
            
            curIndex+=1
        }
    }
    
    //send the user to the assignment page when they click a UIView
    @objc func sendToAssignment(_ sender:TapGesture){
        clickedAssignment = sender.givenIndex
        print("Clicked assignment is: ", clickedAssignment)
        //let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        //let vc = storyBoard.instantiateViewController(withIdentifier: "TAssignSpec") as! UIViewController
        let vc = storyboard?.instantiateViewController(identifier: "TAssignSpec") as! TeacherAssignmentOverview
        //let vc = TeacherAssignmentOverview()
        
        //vc.modalPresentationStyle =
        vc.assignIndex = clickedAssignment
        //self.present(vc, animated:true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    */
}
