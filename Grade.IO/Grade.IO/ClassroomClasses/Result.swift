//
//  Result.swift
//  Grade.IO
//
//  Created by user183542 on 2/5/21.
//

import FirebaseFirestore

public struct Result : Encodable, Decodable {
    var StudentAnswers:[String]?
    var StartTime:Date
    var IndividualStartTime:Date
    var TimeTaken:TimeInterval
    var TimeTakenPerQuestion:[TimeInterval]?
    var StudentID:String
    var AssignmentID:String
    var Grade:Float
    var IsSubmitted:Bool
    
    public init() {
        Grade = 0.0
        IsSubmitted = false
        StudentID = ""
        AssignmentID = ""
        TimeTaken = 0
        StartTime = Date()
        StudentAnswers = []
        TimeTakenPerQuestion = []
        IndividualStartTime = Date()
    }
    
    public mutating func StartTimer() {
        self.StartTime = Date()
    }
    public mutating func StartIndividualQuestionTimer() {
        self.IndividualStartTime = Date()
    }
    public mutating func StopTime() {
        TimeTaken += Date().timeIntervalSince(StartTime)
        StartTime = Date()
    }
    public mutating func StopIndividualTime(ind:Int) {
        TimeTakenPerQuestion![ind] += Date().timeIntervalSince(IndividualStartTime)
        IndividualStartTime = Date()
    }
    public func stringFromTimeInterval(interval: TimeInterval) -> String {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
extension Encodable {
  /// Returns a JSON dictionary, with choice of minimal information
  func getDictionary() -> [String: Any]? {
    let encoder = JSONEncoder()

    guard let data = try? encoder.encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any]
    }
  }
}
extension Decodable {
    /// Initialize from JSON Dictionary. Return nil on failure
    init?(dictionary value: [String:Any]){

      guard JSONSerialization.isValidJSONObject(value) else { return nil }
      guard let jsonData = try? JSONSerialization.data(withJSONObject: value, options: []) else { return nil }

      guard let newValue = try? JSONDecoder().decode(Self.self, from: jsonData) else { return nil }
      self = newValue
    }
  }
