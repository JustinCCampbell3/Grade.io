//
//  TeacherViewController.swift
//  Grade.IO
//
//  Created by user183573 on 1/11/21.
//

import SideMenu
import UIKit

class TeacherViewController: UIViewController {
    //variable for the slide out menu in the teacher view
    var menu: SideMenuNavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menu = SideMenuNavigationController(rootViewController: MenuListController())
        //setting menu to open on the left side. without this it opens on the right
        menu?.leftSide = true
        //hide the white bar at the top of the side menu to make it look better
        //menu?.setNavigationBarHidden(true, animated: false)
        
        //tell the manager which side the menu is on
        SideMenuManager.default.leftMenuNavigationController = menu
        
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
    }
    
    @IBAction func didTapMenu(){
        present(menu!, animated: true)
    }
}


class MenuListController: UITableViewController{
    //array of items in our menu
    var items = ["Student List", "Assignments", "Files", "Account"]
    
    //set a variable for a color
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
    }
}
