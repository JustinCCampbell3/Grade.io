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
        UserHelper.GetStudentByID(id: givenCode) { res in
                self.ID = "GibbsMatt"
                self.SetBio(newBio:res.Bio)
                self.SetEmail(newEmail: res.Email)
                self.SetClassroom(newClass: res.ClassID)
                self.SetFirstName(newFirstName: res.FirstName)
                self.SetLastName(newLastName: res.LastName)
                self.SetBio(newBio: res.Bio)
                self.SetGPA(newGPA: (res as Student).GPA)
                self.SetPhotoPath(newPhotoPath: res.PhotoPath)
                self.SetPronouns(newPronouns: res.Pronouns)
                DatabaseHelper.DeleteDocument(collectionName: String(describing: self.UserType), documentName: givenCode)
                completion(self)
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
        var temp = doc.get(Strings.GPA) as! String
        self.GPA = Float(temp) as! Float
        self.ClassID = doc.get(Strings.CLASS_ID) as! String
    }
    
}
