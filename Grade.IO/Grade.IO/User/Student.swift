//
//  Student.swift
//  Grade.IO
//
//  Created by user183542 on 1/15/21.
//

import Foundation
import FirebaseFirestore

public class Student : BaseUser {
    public var GPA:Float
    public var ClassID:String
    public var Class:Classroom
    
    public override init () {
        GPA = 0.0
        ClassID = ""
        self.Class = Classroom()
        super.init()
        UserType = EUserType.Student
    }
    
    public init(givenCode:String, completion:@escaping (Student)->()) {
        self.GPA = 0.0 // should be init'd to GPAHelper.CalculateGPA(user.ID, user.Classroom)
        self.ClassID = ""
        self.Class = Classroom()
        super.init()
        self.UserType = EUserType.Student
        UserHelper.GetUserByID(id: givenCode) { res in
            completion(res as! Student)
        }
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
            self.GPA = Float(temp as! String) as! Float
        }
        if let temp = doc.get(Strings.CLASS_ID) {
            self.ClassID = temp as! String
            
        }
    }
}
