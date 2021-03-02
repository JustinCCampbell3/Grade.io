//
//  TeacherStudentListPage.swift
//  Grade.IO
//
//  Created by user183573 on 3/2/21.
//

import UIKit
import SideMenu
import TinyConstraints
import Foundation

class TeacherStudentListPage: UIViewController{

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

}
