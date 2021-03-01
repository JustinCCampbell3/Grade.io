//
//  Student.swift
//  Grade.IO
//
//  Created by user183542 on 1/15/21.
//

import Foundation
import FirebaseFirestore

public class Student : BaseUser {
    public var gpa:Float?
    public var classID:String?
    
    public override init () {
        gpa = 0.0
        classID = ""
        super.init()
        userType = Strings.STUDENT
    }
    
    public init(givenCode:String, completion:@escaping (Student)->()) {
        self.gpa = 0.0 // should be init'd to GPAHelper.CalculateGPA(user.ID, user.Classroom)
        self.classID = ""
        super.init()
        self.userType = Strings.STUDENT
        UserHelper.GetUserByID(id: givenCode) { res in
            completion(res as! Student)
        }
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        gpa = try container.decodeIfPresent(Float.self, forKey: .gpa)
        classID = try container.decodeIfPresent(String.self, forKey: .classID)
        try super.init(from: decoder)
    }
    
    public func SetGPA(newGPA:Float) {
        DatabaseHelper.SaveUserPropertyToDoc(user: self, key: Strings.GPA, value: newGPA.description)
    }
    public func SetClassroom(newClass:String) {
        DatabaseHelper.SaveUserPropertyToDoc(user: self, key: Strings.CLASS_ID, value: newClass.description)
    }
    public override func SetPropertiesFromDoc(doc:DocumentSnapshot) {
        super.SetPropertiesFromDoc(doc: doc)
        if let temp = doc.get(Strings.GPA) {
            self.gpa = Float(temp as! String) as! Float
        }
        if let temp = doc.get(Strings.CLASS_ID) {
            self.classID = temp as! String
            
        }
    }
    private enum CodingKeys : String, CodingKey {
        case gpa, classID
    }
}
