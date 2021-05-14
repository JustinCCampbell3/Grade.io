//
//  TeacherViewController.swift
//  Grade.IO
//
//  Created by user183573 on 1/11/21.
//

import SideMenu
import UIKit
import FirebaseStorage

class TeacherViewController: UIViewController, MenuControllerDelegate {
    
    //variable for the slide out menu in the teacher view
    private var sideMenu: SideMenuNavigationController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menu = MenuListController()
        menu.delegate = self
        
        sideMenu = SideMenuNavigationController(rootViewController: menu)
        //setting menu to open on the left side. without this it opens on the right
        sideMenu?.leftSide = true
        //hide the white bar at the top of the side menu to make it look better
        //sideMenu?.setNavigationBarHidden(true, animated: false)
        
        
        //tell the manager which side the menu is on
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        
        //check if this is the homepage, and if so use the name variable to populate the label
        if(self.restorationIdentifier == "THome"){
            name.adjustsFontSizeToFitWidth = true
            name.lineBreakMode = .byClipping
            name.text = CurrentUser.id
        }
        
        //throwing an error upon sign in
        DatabaseHelper.GetClassroomFromID(classID: (CurrentUser as! Teacher).classID!) { res in
            currentClassroom = res
            print(currentClassroom.id)
        }
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

protocol MenuControllerDelegate{
    func didSelectMenuItem(named: String);
}

class MenuListController: UITableViewController{
    public var delegate: MenuControllerDelegate?
    
    //array of items in our menu
    var items = ["Student List", "Assignments", "Files", "Account", "Home"]
    
    //set a variable for a color using RGB (alpha always 1, i think)
    let darkColor = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set background color of the side menu
        tableView.backgroundColor = darkColor
        //register simple cell as this table view's cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return number of rows which = # things in the items array
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //create a cell (like a row) that will go within the menu
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //set the cell's text label to the name of the item at that indexPath
        cell.textLabel?.text = items[indexPath.row]
        //set the cell text to white so it can be read with the background text
        cell.textLabel?.textColor = .white
        //set the background of the cells to the same color as the table itself
        cell.backgroundColor = darkColor
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //Relay to delegate about menu item selection
        let selectedItem = items[indexPath.row]
        delegate?.didSelectMenuItem(named: selectedItem)
    }
}
