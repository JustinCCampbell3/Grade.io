//
//  Teacher.swift
//  Grade.IO
//
//  Created by user183542 on 1/15/21.
//

import FirebaseFirestore

public class Teacher : BaseAdult
{
    public var ClassID:String = ""
    public var Class:Classroom = Classroom()
    public override init() {
        super.init()
        self.UserType = EUserType.Teacher
    }
    public override func SetPropertiesFromDoc(doc: DocumentSnapshot) {
        super.SetPropertiesFromDoc(doc: doc)
        if let temp = doc.get(Strings.CLASS_ID) {
            self.ClassID = temp as! String
        }
    }
}
