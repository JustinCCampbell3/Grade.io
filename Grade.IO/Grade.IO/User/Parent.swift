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

    public init(id:String) {
        super.init()
        self.userType = Strings.PARENT
        SetID(newID: id)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        students = try container.decodeIfPresent([String].self, forKey: .students)
        try super.init(from: decoder)
    }
    
    public func AddStudent(newStudent:String) {
        if (students == nil) {
            students = []
        }
        
        self.students!.append(newStudent)

        DatabaseHelper.GetStudentFromID(studentID: newStudent) { res in
            if (res != nil) {
                let washingtonRef = DatabaseHelper.GetDBReference().collection(Strings.PARENT).document(self.id!)

                washingtonRef.setData([
                    Strings.STUDENTS : FieldValue.arrayUnion([newStudent])
                ], merge: true)
                
                res.SetParentID(newParentID: self.id!)
            }
        }
    }
    
    public func GetStudentObjects(completion:@escaping ([Student]) -> ()) {
        DatabaseHelper.GetDocumentsFromIDs(collection:Strings.STUDENT, ids:students ?? []) { res in
            var tempList:[Student] = []
            for document in res {
                let tempStudent = Student(dictionary: document.data()!)
                tempStudent?.Listen()
                tempList.append(tempStudent!)
            }
            completion(tempList)
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
