//
//  TeacherAssignmentPage.swift
//  Grade.IO
//
//  Created by user183573 on 2/16/21.
//

import UIKit
import SideMenu
import TinyConstraints

class TeacherAssignmentPage: UIViewController, MenuControllerDelegate {
    //variable for the slide out menu in the teacher view
    private var sideMenu: SideMenuNavigationController?
    
    //array of views
    var viewArray:[UIView] = []
    
    
    //add assignment button that will be used for the upper boundary
    @IBOutlet var addAssignBtn: UIButton!
    
    //the width and size var for the
    //lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.size.height + 2000) //need number of assignments to then get how big the scroll view should be (Ask Matt!!!!!!!!!)
    //scroll view to hold everything
    lazy var scrollView: UIScrollView! = {
        let view = UIScrollView(frame: CGRect(x: 0, y: (addAssignBtn.frame.origin.y * 2)  + (addAssignBtn.frame.height), width: self.view.frame.width, height: self.view.frame.height))
        //view.contentSize = contentViewSize
        view.autoresizingMask = .flexibleHeight
        view.bounces = true
        view.showsHorizontalScrollIndicator = true
        return view
    }()
    
    //stack view to hold UIViews within
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.alignment = .center
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.spacing = 120.0
        return view
    }()
    
        /*lazy var containerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100))
        //this is the color of the scroll view background, not the actual full container
        //I hate life
        view.backgroundColor = .systemGreen
        //view.frame.size = contentViewSize
        return view
    }()*/
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Assignment"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("current frame size height:", self.view.frame.size.height)
        
        var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.size.height)
        //let contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.size.height + (120*10)) //height of UIView * # of assignments
        //scrollView.contentSize = contentViewSize
        
        var newHeight = CGFloat(0)
        
        //add a UIView for all the assignments we have
        for i in 0..<15{
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
                //I hate life
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
        
        
        //all scroll view stuff down here
        scrollView.layoutIfNeeded()
        scrollView.isScrollEnabled = true
        
        view.addSubview(scrollView)
        //scrollView.addSubview(stackView)
        //scrollView.addSubview(containerView)
        
        //containerView.addSubview(label)
        //label.center(in: containerView)
        
        for i in viewArray {
            scrollView.addSubview(i)
            //label only adding to the last UIView
            //little bitch
            i.addSubview(label)
            label.center(in: i)
            
            //lines that allow the view to be tapped
            let gesture = UITapGestureRecognizer(target: self, action: #selector(self.sendToAssignment(_sender:)))
            i.addGestureRecognizer(gesture)        }
        
        
        //lines that allow the view to be tapped
        //let gesture = UITapGestureRecognizer(target: self, action: #selector(self.sendToAssignment(_sender:)))
        //self.containerView.addGestureRecognizer(gesture)
    }
    
    //send the user to the assignment page when they click a UIView
    @objc func sendToAssignment(_sender:UITapGestureRecognizer){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: UIViewController = storyBoard.instantiateViewController(withIdentifier: "TAssignSpec") as! UIViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated:true, completion: nil)    }
    
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




