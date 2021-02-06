//
//  Result.swift
//  Grade.IO
//
//  Created by user183542 on 2/5/21.
//

import Foundation

public class Result {
    var CompletionTime:TimeInterval
    var StudentID:String
    var AssignmentID:String
    var Grade:Float
    var IsSubmitted:Bool
    
    public init() {
        CompletionTime = 0.0
        Grade = 0.0
        IsSubmitted = false
        StudentID = ""
        AssignmentID = ""
    }
    
    public func SetCompletionTime(newTime:TimeInterval) {
        
    }
    public func SetGrade(newGrade:Float) {
        
    }
    public func SetStudentID(newStudentID:String) {
        
    }
    public func SetAssignmentID(newAssignmentID:String) {
        
    }
}
