//
//  ParentStudentOverview.swift
//  Grade.IO
//
//  Created by user183573 on 4/3/21.
//

import UIKit

class ParentStudentOverview: UIViewController {

    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var studentNumberGrade: UILabel!
    @IBOutlet weak var studentLetterGrade: UILabel!
    
    
    //array of views
    var viewArray:[UIView] = []
    
    
    //add assignment button that will be used for the upper boundary
    @IBOutlet var studentGrade: UILabel!
    

    //scroll view to hold everything
    lazy var scrollView: UIScrollView! = {
        let view = UIScrollView(frame: CGRect(x: 0, y: (studentGrade.frame.origin.y)  + (studentGrade.frame.height) + 30, width: self.view.frame.width, height: self.view.frame.height))
        //view.contentSize = contentViewSize
        view.autoresizingMask = .flexibleHeight
        view.bounces = true
        view.showsHorizontalScrollIndicator = true
        return view
    }()
    
    //var that will hold the assignments
    var listAssignments: [Assignment] = []
    
    //variable to hold assignment array index that was clicked
    var clickedAssignment: Int = 0
    
    var curAssign: Assignment!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    

}
