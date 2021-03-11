//
//  TeacherAccount.swift
//  Grade.IO
//
//  Created by user183573 on 3/2/21.
//

import UIKit
import SideMenu
import TinyConstraints
import Foundation

class TeacherAccount: UIViewController, MenuControllerDelegate{
    
    //variable for the slide out menu in the teacher view
    private var sideMenu: SideMenuNavigationController?
    
    @IBOutlet weak var teacherFirstName: UILabel!
    
    @IBOutlet weak var teacherLastName: UILabel!
    
    @IBOutlet weak var teacherEmail: UILabel!
    
    @IBOutlet weak var teacherNum: UILabel!
    
    @IBOutlet weak var teacherBio: UILabel!
    
    @IBOutlet weak var teacherPronouns: UILabel!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //get teacher info
        UserHelper.GetTeacherByID(id: CurrentUser.id!) { (res) in
            self.populateTeacherLabels(teacher: res)
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
    
    private func populateTeacherLabels(teacher: Teacher){
        teacherFirstName.text = teacher.firstName
        teacherLastName.text = teacher.lastName
        teacherPronouns.text = teacher.pronouns
        teacherEmail.text = teacher.email
        teacherNum.text = teacher.phoneNumber
        teacherBio.text = teacher.bio
         
        /*
        teacherFirstName.text = CurrentUser.firstName
        teacherLastName.text = CurrentUser.lastName
        teacherPronouns.text = CurrentUser.pronouns
        teacherEmail.text = CurrentUser.email
        teacherNum.text = CurrentUser.pronouns
        teacherBio.text = CurrentUser.bio*/
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
