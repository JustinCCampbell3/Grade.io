//
//  TeacherAssignmentPage.swift
//  Grade.IO
//
//  Created by user183573 on 2/16/21.
//

import UIKit
import SideMenu
import TinyConstraints
import Foundation

class TeacherAssignmentPage: UIViewController, MenuControllerDelegate {
    //variable for the slide out menu in the teacher view
    private var sideMenu: SideMenuNavigationController?
    
    //array of views
    var viewArray:[UIView] = []
    
    
    //add assignment button that will be used for the upper boundary
    @IBOutlet var addAssignBtn: UIButton!
    

    //scroll view to hold everything
    lazy var scrollView: UIScrollView! = {
        let view = UIScrollView(frame: CGRect(x: 0, y: (addAssignBtn.frame.origin.y * 2)  + (addAssignBtn.frame.height), width: self.view.frame.width, height: self.view.frame.height))
        //view.contentSize = contentViewSize
        view.autoresizingMask = .flexibleHeight
        view.bounces = true
        view.showsHorizontalScrollIndicator = true
        return view
    }()
    
    //var that will hold the assignments
    var listAssignments: [Assignment] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //create a scroll view based on the number of assignments we have
        //may have to change testClass to myClass later
        DatabaseHelper.GetAssignmentsFromClassID(classID: "testClass") { (res) in
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
        
        //SideMenuManager.default.addPanGestureToPresent(toView: self.view)
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
            dueDateLabel.left(to: i, offset: 30)
            dueDateLabel.top(to: i, offset: (i.frame.height/2)-nameLabel.frame.height) //halfway down the view
            
            
            
            //lines that allow the view to be tapped
            let gesture = UITapGestureRecognizer(target: self, action: #selector(self.sendToAssignment(_sender:)))
            i.addGestureRecognizer(gesture)
            
            curIndex+=1
        }
    }
    
    //send the user to the assignment page when they click a UIView
    @objc func sendToAssignment(_sender:UITapGestureRecognizer){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: UIViewController = storyBoard.instantiateViewController(withIdentifier: "TAssignSpec") as! UIViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated:true, completion: nil)
    }
    
    @IBOutlet weak var name: UILabel!
    
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




