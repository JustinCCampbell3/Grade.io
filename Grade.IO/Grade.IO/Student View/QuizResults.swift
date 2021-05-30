//
//  QuizResults.swift
//  Grade.IO
//
//  Created by Justin Campbell on 4/16/21.
//

import Foundation

import UIKit

class QuizResults: UIViewController {
    
    @IBOutlet weak var TotalScore: UILabel!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var assignName: UILabel!
    //var that will hold the assignments
    var listAssignments: [Assignment] = []
    
    override func viewDidLoad() {
        TotalScore.text = String(Double(finalQuizGrade)! * 100.0) + "%"
        assignName.text = CurrentAssignment.name!
        
        //get assignments to try to find the assignment number for this
        currentClassroom.GetAssignmentObjects { (res) in
            self.findAssignments(assignments: res)
            self.giveSubmitGesture()
        }
        
    }
    
    private func giveSubmitGesture() {
        //find the index number of the assignment we have
        var curIndex = 0
        var assignNum = 0
        for i in listAssignments{
            if(i.name!.caseInsensitiveCompare(CurrentAssignment.name!) == .orderedSame){
                //we have same name
                assignNum = curIndex
                print("assignment name: ", i.name!)
            }
            curIndex+=1
        }
        
        //gesture for the submit button
        let gesture = TapGesture(target: self, action: #selector(self.sendToAssignment(_:)))
        gesture.givenIndex = assignNum
        submitBtn.addGestureRecognizer(gesture)
    }
    
    private func findAssignments(assignments: [Assignment]){
        for i in assignments {
            listAssignments.append(i)
            //print("assignment name: ", i.name!)
        }
    }
    
    //send the user to the assignment page when they click a UIView
    @objc func sendToAssignment(_ sender:TapGesture) {
        //CurrentAssignment = listAssignments[clickedAssignment]
        let vc = storyboard?.instantiateViewController(identifier: "SAssignOviewPage") as! StudentAssignmentOverview
        vc.assignIndex = sender.givenIndex
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated:true, completion: nil)
        
    }
    
}
