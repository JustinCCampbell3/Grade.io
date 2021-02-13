//
//  Result.swift
//  Grade.IO
//
//  Created by user183542 on 2/5/21.
//

import FirebaseFirestore

public struct Result : Encodable, Decodable {
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
    
    public mutating func StartTimer() {
        self.StartTime = Date()
    }
    
    public mutating func StopTime() {
        TimeTaken += StartTime.timeIntervalSinceNow
    }
    public func SetGrade(newGrade:Float) {
    }
    public func SetStudentID(newStudentID:String) {
        DatabaseHelper.SavePropertyToDatabase(collection: Strings.ASSIGNMENT, document: AssignmentID, key: Strings.RESULTS, value: getDictionary())
    }
    public func SetAssignmentID(newAssignmentID:String) {
        
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
