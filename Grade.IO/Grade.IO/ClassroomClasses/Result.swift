//
//  Result.swift
//  Grade.IO
//
//  Created by user183542 on 2/5/21.
//

import FirebaseFirestore

public class Result {
    var StartTime:Date
    var TimeTaken:Double
    var StudentID:String
    var AssignmentID:String
    var Grade:Float
    var IsSubmitted:Bool
    
    public init() {
        StartTime = Date()
        Grade = 0.0
        IsSubmitted = false
        StudentID = ""
        AssignmentID = ""
        TimeTaken = 0
    }
    
    public func StartTimer() {
        StartTime = Date()
    }
    
    public func StopTime() {
        TimeTaken += StartTime.timeIntervalSinceNow
    }
    public func SetGrade(newGrade:Float) {
    }
    public func SetStudentID(newStudentID:String) {
        
    }
    public func SetAssignmentID(newAssignmentID:String) {
        
    }
}
