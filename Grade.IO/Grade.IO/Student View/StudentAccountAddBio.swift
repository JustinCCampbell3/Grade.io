//
//  StudentAccountAddBio.swift
//  Grade.IO
//
//  Created by user183573 on 3/11/21.
//

import UIKit

class StudentAccountAddBio: UIViewController {
    
    @IBOutlet weak var studentBio: UITextView!
    @IBOutlet weak var curView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    

    @IBAction func confirmBioChange(){
        let newBio: String = studentBio.text!
        print("new bio: " + newBio)
        CurrentUser.SetBio(newBio: newBio)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let curVC = storyboard.instantiateViewController(identifier: "SAccount")
        
        //let vc: UINavigationController = storyBoard.instantiateViewController(withIdentifier: "TSLNav") as! UINavigationController
        //let vc: UIViewController = storyBoard.instantiateViewController(withIdentifier: "TStudentList") as! UIViewController
        curVC.modalPresentationStyle = .fullScreen
        self.present(curVC, animated:true, completion: nil)
        //curView.isHidden = true
    }

}
