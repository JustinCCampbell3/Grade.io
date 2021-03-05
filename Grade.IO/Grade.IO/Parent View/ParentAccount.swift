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
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    //@IBOutlet weak var firstName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       /* UserHelper.GetUserByID(id: CurrentUser.id!) { (res) in
            self.popParentInfo(parent: (res as! Parent))
        }*/
        
    }
    

    private func popParentInfo(){
        /*
        lastName.text = parent.lastName
        firstName.text = parent.firstName
        email.text = parent.email
        phoneNumber.text = parent.phoneNumber
        */
        
        lastName.text = CurrentUser.lastName
        firstName.text = CurrentUser.firstName
        email.text = CurrentUser.email
        //phoneNumber.text = CurrentUser.phoneNumber
    }

}
