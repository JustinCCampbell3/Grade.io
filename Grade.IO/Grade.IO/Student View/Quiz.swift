//
//  Quiz.swift
//  Grade.IO
//
//  Created by Justin Campbell on 3/5/21.
//

import UIKit

import Foundation

//holds variables
struct Question{
    var Question : String! //variable to list question
  //  var Answers : [String]! //array of answers
    var Answer : Int! //correct answer
}

class Quiz: UIViewController{
    
    @IBOutlet weak var Qlabel: UILabel!
    
    @IBOutlet weak var StudentInput: UITextField!
    
    var Questions = [Question]()
    
    var QNumber = Int()
    
    var totalScore = Int()
    
    var Answers = Int()
    
    
    @IBOutlet weak var StudentScore: UILabel!
    
    override func viewDidLoad() {
        Questions = [Question(Question: "What is 5+3", Answer: 8), Question(Question: "What is 2+5", Answer: 7), Question(Question: "What is 2+6", Answer: 8), Question(Question: "What is 1+1", Answer: 2), Question(Question: "What is 2+3", Answer: 5), Question(Question: "What is 7+9", Answer: 16), Question(Question: "Submit Quiz", Answer: 0)]
        
        PickQuestion()
    }
    
    func PickQuestion(){
        if Questions.count > 0{
            QNumber = 0
            Qlabel.text = Questions[QNumber].Question
            Answers = Questions[QNumber].Answer
            
           // StudentScore.text = String(totalScore)
            
            Questions.remove(at: QNumber)
        }
        
        else{
            
        }
        
    }
    /*
    func PickPreviousQuestion(){
        if Questions.count > 0{
            QNumber-=1
            Qlabel.text = Questions[QNumber-1].Question
            Answers = Questions[QNumber].Answer
            
           // StudentScore.text = String(totalScore)
            
            //Questions.remove(at: QNumber)
        }
        
        else{
            
        }
        
    }
 */
    
    @IBAction func NextPressed(_ sender: UIButton) {
        
        let guess:Int? = Int(StudentInput.text!)
        if guess == Answers{
            totalScore+=1
            NSLog("Correct")
            StudentInput.text = ""
        }
        else{
            NSLog("Incorrect")
            StudentInput.text = ""
        }
        
        PickQuestion()
    }
    
  /*
    @IBAction func PreviousPressed(_ sender: Any) {
        PickPreviousQuestion()
    }
    */
    
}
