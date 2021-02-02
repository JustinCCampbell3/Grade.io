//
//  DatabaseHelper.swift
//  Grade.IO
//
//  Created by user183542 on 1/9/21.
//

import Firebase
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
        DatabaseHelper.GetDocumentReference(collectionName: String(describing: user.UserType), documentName: user.ID).setData([
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
}

