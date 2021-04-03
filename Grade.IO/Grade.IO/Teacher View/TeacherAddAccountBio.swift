//
//  TeacherAddAccountBio.swift
//  Grade.IO
//
//  Created by user183573 on 3/30/21.
//

import UIKit

class TeacherAddAccountBio: UIViewController {
    
    @IBOutlet weak var teacherBio: UITextView!
    @IBOutlet weak var curView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func confirmBioChange(){
        let newBio: String = teacherBio.text!
        print("new bio: " + newBio)
        CurrentUser.SetBio(newBio: newBio)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let curVC = storyboard.instantiateViewController(withIdentifier: "TAcNav") as! UINavigationController
        //let vc: UIViewController = storyBoard.instantiateViewController(withIdentifier: "TAccount") as! UIViewController
        curVC.modalPresentationStyle = .fullScreen
        self.present(curVC, animated:true, completion: nil)
        //curView.isHidden = true
    }

}
