//
//  Quiz.swift
//  Grade.IO
//
//  Created by Justin Campbell on 3/5/21.
//

import UIKit

import Foundation

var CurrentAssignment:Assignment = Assignment(newID:"NULL")

class Quiz: UIViewController {
    
    @IBOutlet weak var Qlabel: UILabel!
    
    @IBOutlet weak var StudentInput: UITextField!
    
    var StudentsAnswers: Array<String?> = Array(repeating: "", count: CurrentAssignment.problems!.count)

    var qIndex:Int = 0
    var currentProblem:Problem = Problem()
    var result:Result = Result()
    
    var totalPossibleGrade = CurrentAssignment.problems?.count
    var existingResult:Result = Result()
    
    @IBOutlet weak var StudentScore: UILabel!
    
    override func viewDidLoad() {
        if CurrentAssignment.problems!.count <= 0 {
            DoAlert(title: "No questions!", body: "There are no questions in this assignment, this is an issue that you should tell your teacher about.", vc: self)
        }
        existingResult = (CurrentAssignment.results?.first(where:{$0.StudentID == CurrentUser.id})) ?? Result()
        result = existingResult.Grade != 0.0 ? existingResult : Result()
        result.StartTimer()
        setCurrentQuestion(index: qIndex)
    }

    @IBAction func BackButtonPressed(_ sender: Any) {
        if (qIndex > 0) {
            StudentsAnswers[qIndex] = self.StudentInput.text ?? StudentsAnswers[qIndex]
            qIndex -= 1
            setCurrentQuestion(index: qIndex)
        }
    }
    
    
    @IBAction func SubmitButtonPressed(_ sender: Any) {
        StudentsAnswers[qIndex] = self.StudentInput.text ?? StudentsAnswers[qIndex]
        let grade = doGrading()
        let result = createResult(grade:grade)
        insertResult(result:result)
        
        
        // segue back to assignment page here
    }
    
    func doGrading() -> Float {
        var count = 0
        var tempGrade = 0
        for answer in StudentsAnswers {
            if answer == CurrentAssignment.problems![count].Answer {
                tempGrade += 1
            }
            count += 1
        }
        return  Float(tempGrade) / Float(totalPossibleGrade!)
    }
    func createResult(grade:Float) -> Result {
        result.Grade = grade
        result.AssignmentID = CurrentAssignment.id!
        result.IsSubmitted = true
        result.StopTime()
        print(result.stringFromTimeInterval(interval: result.TimeTaken))
        result.StudentID = CurrentUser.id!
        return result
    }
    func insertResult(result:Result) {
        if existingResult != nil {
            // put something here, probably 0_o
        }
        else {
            CurrentAssignment.AddResult(newResult: result)
        }
    }
    @IBAction func NextButtonPressed(_ sender: Any) {
        if (qIndex < CurrentAssignment.problems!.count - 1) {
            StudentsAnswers[qIndex] = self.StudentInput.text ?? StudentsAnswers[qIndex]
            qIndex += 1
            setCurrentQuestion(index: qIndex)
        }
    }
    /*@IBAction func NextButton(_ sender: UIButton) {
        if (qIndex > 0) {
            qIndex += 1
            setCurrentQuestion(index: qIndex)
        }
    }*/

    /*@IBAction func BackButton(_ sender: UIButton) {
        if (qIndex > 0) {
            StudentsAnswers[qIndex] = self.StudentInput.text!
            qIndex -= 1
            setCurrentQuestion(index: qIndex)
        }
    }*/
    
    func setCurrentQuestion(index:Int) {
        currentProblem = CurrentAssignment.problems?[index] ?? Problem()
        self.StudentInput.text = StudentsAnswers[qIndex]
        self.Qlabel.text = currentProblem.Question
        
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
    
}

