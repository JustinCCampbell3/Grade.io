//
//  DatabaseHelper.swift
//  Grade.IO
//
//  Created by user183542 on 1/9/21.
//

import Firebase
import FirebaseFirestoreSwift
public class DatabaseHelper {
    
    public static func GetDBReference() -> Firestore {
        return Firestore.firestore()
    }
    public static func GetCollection(collectionName:String) -> CollectionReference {
        return GetDBReference().collection(collectionName)
    }
    public static func GetDocumentReference(collectionName:String, documentName:String) -> DocumentReference {
        return GetCollection(collectionName: collectionName).document(documentName)
    }
    
    public static func SaveUserPropertyToDoc(user:BaseUser, key:String, value:String) {
        DatabaseHelper.GetDocumentReference(collectionName: String(describing: user.userType), documentName: user.id ?? "").setData([
                key : value
            ], merge: true
        )
    }
    public static func SavePropertyToDatabase<T>(collection:String, document:String, key:String, value:T) {
        DatabaseHelper.GetDocumentReference(collectionName: collection, documentName: document).setData([
                key : value
            ], merge: true
        )
    }
    
    public static func GetDocument(collectionName:String, documentName:String, completion:@escaping(([String:Any]?) -> Void)) {
        let docRef = DatabaseHelper.GetDocumentReference(collectionName:collectionName, documentName:documentName)
        docRef.getDocument { (document, error) in
             if let document = document, document.exists {
                 let docData = document.data()
                 completion(docData)
              } else {
                 print("Document does not exist")
              }
        }
    }
    public static func DeleteDocument(collectionName:String, documentName:String) {
        GetDBReference().collection(collectionName).document(documentName).delete() { err in
            if (err != nil) {
                print("problem deleting document")
            }
            else {
                print("document deleted")
            }
        }
    }
    
    /// Get all assignments from the DB that have a field classID which equals the one passed in as a param to the function
    /// Ex: GetAssignmentsFromClassID(classID:"myClass") will get you the array of all assignments that have a field equal to classID:myClass
    public static func GetDocsFromKeyValue(collection:String, key:String, value:String, completion: @escaping ([QueryDocumentSnapshot])->()) {
        DatabaseHelper.GetDBReference().collection(Strings.STUDENT).whereField(key, isEqualTo: value).getDocuments { (snapshot, error) in
            if let error = error {
                // There aint no assignments that have a 'classID' equal to the parameter classID
                print("Error getting documents: \(error)")
            } else {
                completion(snapshot!.documents)  // res
            }
        }
    }
    public static func StudentsFromKeyValue(key:String, value:String, completion: @escaping ([Student])->()) {
        var students:[Student] = []
        GetDocsFromKeyValue(collection: Strings.STUDENT, key: key, value: value) { res in
            for d in res {
                let student = Student(dictionary: d.data())
                student?.Listen()
                students.append(student!)
            }
            completion(students)
        }
    }
    public static func AssignmentsFromKeyValue(key:String, value:String, completion: @escaping ([Assignment])->()) {
        var assignments:[Assignment] = []
        GetDocsFromKeyValue(collection: Strings.ASSIGNMENT, key: key, value: value) { res in
            for d in res {
                let assignment = Assignment(dictionary: d.data())
                assignment?.Listen()
                assignments.append(assignment!)
            }
            completion(assignments)
        }
    }
    /// Get all assignments from the DB that have a field classID which equals the one passed in as a param to the function
    /// Ex: GetAssignmentsFromClassID(classID:"myClass") will get you the array of all assignments that have a field equal to classID:myClass
    public static func GetAssignmentsFromClassID(classID:String, completion: @escaping ([Assignment])->()) {
        DatabaseHelper.GetDBReference().collection(Strings.ASSIGNMENT).whereField(Strings.CLASS_ID, isEqualTo: classID).getDocuments { (snapshot, error) in
            if let error = error {
                // There aint no assignments that have a 'classID' equal to the parameter classID
                print("Error getting documents: \(error)")
            } else {
                // Convert documents from snapshot into Assignments, call listen to keep them up to date, and add them to the return array.
                var assignments:[Assignment] = []
                for document in snapshot!.documents {
                    // this is the actual call that converts DB JSON to an Assignment object, thanks to the Codable protocol
                    var temp = Assignment(dictionary: document.data())
                    temp?.Listen()
                    assignments.append(temp!)
                }
                completion(assignments)  // res
            }
        }
    }
}
