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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set the username label
        username.text = CurrentUser.id
        print("parent's username is: ", CurrentUser.id)
        
        //get the parent by current user id
        UserHelper.GetParentByID(id: CurrentUser.id!) { (res) in
            //get the children from the current parent
            res.GetChildren { (children) in
                //go through and make the children pics and stuff
                self.getParentChildren(children: children)
            }
        }
        
    }
    
    private func getParentChildren(children: [Student]){
        
    }
    
}
