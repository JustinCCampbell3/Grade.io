//
//  Parent.swift
//  Grade.IO
//
//  Created by user183542 on 1/15/21.
//

import FirebaseFirestore
public class Parent : BaseAdult {

    public var Students:[String] = []

    public override init() {
        super.init()
        self.UserType = EUserType.Parent
    }
    public func AddStudent(id:String) {
        UserHelper.GetUserByID(id:id) { res in
            if (res != nil) {
                self.Students.append(id)
            }
            else {
                print("error")
            }
        }
    }
    public override func SetPropertiesFromDoc(doc: DocumentSnapshot) {
        super.SetPropertiesFromDoc(doc: doc)
        if let temp = doc.get(Strings.STUDENTS) {
            self.Students = temp as! [String]
        }
    }
}
