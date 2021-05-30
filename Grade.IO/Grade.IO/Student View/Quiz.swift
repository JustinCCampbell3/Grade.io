//
//  Quiz.swift
//  Grade.IO
//
//  Created by Justin Campbell on 3/5/21.
//

import UIKit

import Foundation

var finalQuizGrade = ""

var CurrentAssignment:Assignment = Assignment(newID:"NULL")

class Quiz: UIViewController {
    
    @IBOutlet weak var Qlabel: UILabel!
    
    @IBOutlet weak var StudentInput: UITextField!
    
    @IBOutlet weak var QNumber: UILabel!
    
    @IBOutlet weak var AssignName: UILabel!
    
    var StudentsAnswers: [String] = Array(repeating: "", count: CurrentAssignment.problems!.count)
    var TimeTakenPerQuestion: [TimeInterval] = Array(repeating: 0, count: CurrentAssignment.problems!.count)
    var qIndex:Int = 0
    var currentProblem:Problem = Problem()
    var result:Result = Result()
    
    var totalPossibleGrade = CurrentAssignment.problems?.count
    var existingResult:Result = Result()
    
    
    
    override func viewDidLoad() {
        if CurrentAssignment.problems!.count <= 0 {
            DoAlert(title: "No questions!", body: "There are no questions in this assignment, this is an issue that you should tell your teacher about.", vc: self)
        }
        existingResult = (CurrentAssignment.results?.first(where:{$0.StudentID == CurrentUser.id})) ?? Result()
        result = existingResult.Grade != 0.0 ? existingResult : Result()
        result.StartTimer()
        result.StartIndividualQuestionTimer()
        setCurrentQuestion(index: qIndex)
        result.TimeTakenPerQuestion = Array(repeating: 0, count: CurrentAssignment.problems!.count)
    }

    @IBAction func BackButtonPressed(_ sender: Any) {
        if (qIndex > 0) {
            StudentsAnswers[qIndex] = self.StudentInput.text ?? StudentsAnswers[qIndex]
            result.StopIndividualTime(ind: qIndex)
            print(result.stringFromTimeInterval(interval: result.TimeTakenPerQuestion![qIndex]))

            qIndex -= 1
            setCurrentQuestion(index: qIndex)
            result.StartIndividualQuestionTimer()
        }
    }
    
    
    @IBAction func SubmitButtonPressed(_ sender: Any) {
        StudentsAnswers[qIndex] = self.StudentInput.text ?? StudentsAnswers[qIndex]
        let grade = doGrading()
        let result = createResult(grade:grade)
        finalQuizGrade = "\(grade)"
        insertResult(result:result)
        print(TimeTakenPerQuestion)
        
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
        result.StopIndividualTime(ind: qIndex)
        print(result.stringFromTimeInterval(interval: result.TimeTaken))
        result.StudentID = CurrentUser.id!
        result.StudentAnswers = StudentsAnswers
        return result
    }
    func insertResult(result:Result) {
        existingResult = (CurrentAssignment.results?.first(where:{$0.StudentID == CurrentUser.id})) ?? Result()
        if !existingResult.StudentID.isEmpty {
            let index = CurrentAssignment.GetResultIndexByID(id: CurrentUser.id!)
            CurrentAssignment.results?.remove(at: index)
            let temp = CurrentAssignment.results
            CurrentAssignment.ClearResults()
            if (temp != nil) {
                CurrentAssignment.AddResult(newResult: result)
            }
            else {
                for r in temp! {
                    CurrentAssignment.AddResult(newResult: r)
                }
            }
        }
        else {
            CurrentAssignment.AddResult(newResult: result)
        }
    }
    @IBAction func NextButtonPressed(_ sender: Any) {
        if (qIndex < CurrentAssignment.problems!.count - 1) {
            StudentsAnswers[qIndex] = self.StudentInput.text ?? StudentsAnswers[qIndex]
            result.StopIndividualTime(ind: qIndex)
            qIndex += 1
            result.StartIndividualQuestionTimer()
            print(result.stringFromTimeInterval(interval: result.TimeTakenPerQuestion![qIndex-1]))
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
        self.QNumber.text = "Question " + String((index+1)) + "/" + String((CurrentAssignment.problems!.count))
        self.AssignName.text = CurrentAssignment.name
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

