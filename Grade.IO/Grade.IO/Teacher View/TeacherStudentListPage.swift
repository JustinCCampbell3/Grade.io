//
//  TeacherStudentListPage.swift
//  Grade.IO
//
//  Created by user183573 on 3/2/21.
//

import UIKit
import SideMenu
import TinyConstraints
import Foundation

class TeacherStudentListPage: UIViewController, MenuControllerDelegate{
    
    //variable for the slide out menu in the teacher view
    private var sideMenu: SideMenuNavigationController?
    
    //array of views
    var viewArray:[UIView] = []
    
    
    //add assignment button that will be used for the upper boundary
    @IBOutlet var searchBtn: UIButton!
    

    //scroll view to hold everything
    lazy var scrollView: UIScrollView! = {
        let view = UIScrollView(frame: CGRect(x: 0, y: (searchBtn.frame.origin.y)  + (searchBtn.frame.height * 2), width: self.view.frame.width, height: self.view.frame.height))
        //view.contentSize = contentViewSize
        view.autoresizingMask = .flexibleHeight
        view.bounces = true
        view.showsHorizontalScrollIndicator = true
        return view
    }()
    
    //holds the list of students for the current teacher
    var studentList: [Student] = []
    
    //var to hold the clicked student index number in the array
    var clickedStudent: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //create the scroll view for the list of students
        currentClassroom.GetStudentObjects { (res) in
            self.makeScrollView(newList: res)
        }
        
        //creating the side menu starts here
        let menu = MenuListController()
        menu.delegate = self
        
        sideMenu = SideMenuNavigationController(rootViewController: menu)
        //setting menu to open on the left side. without this it opens on the right
        sideMenu?.leftSide = true
        //hide the white bar at the top of the side menu to make it look better
        //sideMenu?.setNavigationBarHidden(true, animated: false)
        
        
        //tell the manager which side the menu is on
        SideMenuManager.default.leftMenuNavigationController = sideMenu
    }
    
    //get all students in an array
    private func getStudentList(students: [Student]){
        for i in students {
            studentList.append(i)
        }
    }
    
    private func makeScrollView(newList: [Student]){
        //make a list of assignments
        self.getStudentList(students: newList)
        
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

            //making label here makes sure each view has their own label
            //label for assignment name
            let firstnameLabel: UILabel = {
                let label = UILabel()
                label.text = studentList[curIndex].firstName
                return label
            }()
            i.addSubview(firstnameLabel)
            firstnameLabel.left(to: i, offset: 30)
            firstnameLabel.top(to: i, offset: (i.frame.height/4)-firstnameLabel.frame.height)
            
            //label for due date
            let lastnameLabel: UILabel = {
                let label = UILabel()
                label.text = studentList[curIndex].lastName
                return label
            }()
            i.addSubview(lastnameLabel)
            lastnameLabel.left(to: i, offset: 30)
            lastnameLabel.top(to: i, offset: (i.frame.height/2)-lastnameLabel.frame.height) //halfway down the view
            
            
            
            //lines that allow the view to be tapped
            let gesture = TapGesture(target: self, action: #selector(self.sendToStudent(_:)))
            //grab the array index of the student that has been tapped
            gesture.givenIndex = curIndex
            i.addGestureRecognizer(gesture)
            
            
            curIndex+=1
        }
    }
    
    //send the user to the assignment page when they click a UIView
    @objc func sendToStudent(_ sender:TapGesture){
        clickedStudent = sender.givenIndex
        print("Clicked student is: ", clickedStudent)
        //let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        //let vc = storyBoard.instantiateViewController(withIdentifier: "TAssignSpec") as! UIViewController
        let vc = storyboard?.instantiateViewController(identifier: "TStudentOview") as! TeacherOverviewStudentList
        
        //vc.modalPresentationStyle =
        vc.studentIndex = clickedStudent
        //self.present(vc, animated:true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didTapMenu(){
        present(sideMenu!, animated: true)
    }
    
    func didSelectMenuItem(named: String) {
        
        //once menu has dismissed, go to that screen
        sideMenu?.dismiss(animated: true, completion: {
            if named == "Student List"{
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc: UINavigationController = storyBoard.instantiateViewController(withIdentifier: "TSLNav") as! UINavigationController
                //let vc: UIViewController = storyBoard.instantiateViewController(withIdentifier: "TStudentList") as! UIViewController
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated:true, completion: nil)
                //self.navigationController?.pushViewController(vc, animated: true)
                
            }
            else if named == "Assignments"{
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc: UINavigationController = storyBoard.instantiateViewController(withIdentifier: "TAsNav") as! UINavigationController
                //let vc: UIViewController = storyBoard.instantiateViewController(withIdentifier: "TAssignment") as! UIViewController
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated:true, completion: nil)
                //self.navigationController?.pushViewController(vc, animated: true)
            }
            else if named == "Files"{
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc: UINavigationController = storyBoard.instantiateViewController(withIdentifier: "TFNav") as! UINavigationController
                //let vc: UIViewController = storyBoard.instantiateViewController(withIdentifier: "TFiles") as! UIViewController
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated:true, completion: nil)
                //self.navigationController?.pushViewController(vc, animated: true)
            }
            else if named == "Account"{
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc: UINavigationController = storyBoard.instantiateViewController(withIdentifier: "TAcNav") as! UINavigationController
                //let vc: UIViewController = storyBoard.instantiateViewController(withIdentifier: "TAccount") as! UIViewController
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated:true, completion: nil)
                //self.navigationController?.pushViewController(vc, animated: true)
            }
            else if named == "Home"{
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                //let vc: UIViewController = storyBoard.instantiateViewController(withIdentifier: "THome") as! UIViewController
                let vc: UITabBarController = storyBoard.instantiateViewController(withIdentifier: "THomeTab") as! UITabBarController
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated:true, completion: nil)
                //self.navigationController?.pushViewController(vc, animated: true)
            }
        })
    }

}
