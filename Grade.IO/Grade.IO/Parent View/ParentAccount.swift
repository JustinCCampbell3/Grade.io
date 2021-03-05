//
//  ParentAccount.swift
//  Grade.IO
//
//  Created by user183573 on 3/4/21.
//

import UIKit

class ParentAccount: UIViewController {

    //the parent we want
    
    
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var astName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    //@IBOutlet weak var firstName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UserHelper.GetUserByID(id: CurrentUser.id!) { (res) in
            self.popParentInfo(parent: (res as! Parent))
        }
        
    }
    

    private func popParentInfo(parent: Parent){
        
    }

}
