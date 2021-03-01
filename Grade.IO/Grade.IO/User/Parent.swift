//
//  Parent.swift
//  Grade.IO
//
//  Created by user183542 on 1/15/21.
//

import FirebaseFirestore
public class Parent : BaseAdult {

    public var students:[String]?
    public var studentObjects:[Student]?

    public override init() {
        super.init()
        self.userType = Strings.PARENT
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        students = try container.decodeIfPresent([String].self, forKey: .students)
        try super.init(from: decoder)
    }
    
    public func AddStudent(id:String) {
        if (students == nil)
        {
            students = []
        }
        UserHelper.GetUserByID(id:id) { res in
            if (res != nil) {
                self.students!.append(id)
                DatabaseHelper.SavePropertyToDatabase(collection: Strings.[are], document: <#T##String#>, key: <#T##String#>, value: <#T##T#>)
            }
            else {
                print("error")
            }
        }
    }
    
    public override func SetPropertiesFromDoc(doc: DocumentSnapshot) {
        super.SetPropertiesFromDoc(doc: doc)
        if let temp = doc.get(Strings.STUDENTS) {
            self.students = temp as! [String]
        }
    }
    private enum CodingKeys : String, CodingKey {
        case students
    }
}
