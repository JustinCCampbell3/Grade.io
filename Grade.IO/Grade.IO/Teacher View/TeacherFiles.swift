//
//  TeacherFiles.swift
//  Grade.IO
//
//  Created by user183573 on 5/9/21.
//

import UIKit
import SideMenu
import TinyConstraints
import Foundation

class TeacherFiles: UIViewController, MenuControllerDelegate  {
    //variable for the slide out menu in the teacher view
    private var sideMenu: SideMenuNavigationController?
    
    //array of views
    var viewArray:[UIView] = []
    
    //label for all current files
    @IBOutlet weak var filePageLabel: UILabel!
    

    //scroll view to hold everything
    lazy var scrollView: UIScrollView! = {
        let view = UIScrollView(frame: CGRect(x: 0, y: (filePageLabel.frame.origin.y * 2)  + (filePageLabel.frame.height), width: self.view.frame.width, height: self.view.frame.height - filePageLabel.frame.origin.y))
        //view.contentSize = contentViewSize
        view.autoresizingMask = .flexibleHeight
        view.bounces = true
        view.showsHorizontalScrollIndicator = true
        return view
    }()
    
    //var that will hold the assignments
    var listAssignments: [Assignment] = []
    
    //var curAssign: Assignment!
    
    //variable to access classroom class
    var curClassroom: Classroom!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentClassroom.GetAssignmentObjects { (res) in
            //self.getAssignmentList(assignments: res)
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
    
    //change listAssignments to have all the assignments
    private func getAssignmentList(assignments: [Assignment]){
        for i in assignments {
            listAssignments.append(i)
        }
    }
    
    private func makeScrollView(newList: [Assignment]){
        //make a list of assignments
        self.getAssignmentList(assignments: newList)
        //self.getAssignmentList(assignments: newList)
        
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
            let fileLabel: UILabel = {
                let label = UILabel()
                label.text = "Assignment " + String((curIndex+1)) + ": " + listAssignments[curIndex].filePath!
                return label
            }()
            i.addSubview(fileLabel)
            print("view center: ", view.center)
            //fileLabel.left(to: i, offset: (i.center.x))
            fileLabel.center(in: i, offset: CGPoint(x: 0, y: 0))
            //fileLabel.top(to: i, offset: (i.frame.height/2)-fileLabel.frame.height)
            
            
            //lines that allow the view to be tapped
            //let gesture = TapGesture(target: self, action: #selector(self.sendToAssignment(_:)))
            //gesture.givenIndex = curIndex
            //i.addGestureRecognizer(gesture)
            
            
            curIndex+=1
        }
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
