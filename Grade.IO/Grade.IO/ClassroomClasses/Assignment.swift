//
//  Assignment.swift
//  Grade.IO
//
//  Created by user183542 on 2/5/21.
//

import Foundation

public struct Problem {
    public var Question:String = ""
    public var Answer:String = ""
}

public class Assignment {
    public var Results:[Result]
    public var Problems:[Problem]
    public var DueDate:Date
    public var ID:String
    public var ClassID:String
    public var FilePath:String
    public var Overview:String
    
    public init() {
        Results = []
        Problems = []
        DueDate = Date.init()
        ID = ""
        ClassID = ""
        FilePath = ""
        Overview = ""
    }
    
    public func AddResult(newResult:Result) {
        Results.append(newResult)
    }
    public func AddProblem(newProblem:Problem) {
        Problems.append(newProblem)
    }
    public func GetAverageTime() -> TimeInterval {
        var sum = 0.0
        for result in Results {
            sum += result.CompletionTime
        }
        return (sum/(Double(Results.count)))
    }
}
