//
//  DatabaseHelper.swift
//  Grade.IO
//
//  Created by user183542 on 1/9/21.
//

import Foundation
import FirebaseFirestore
public class DatabaseHelper {
    public static func IsInDatabase(collection:String, document:String) -> Bool {
        var result = false
        GetDBReference().collection(collection).document(document).getDocument() { (document,error) in
            result = document?.exists != nil
        }
        return result;
    }
    public static func GetDBReference() -> Firestore {
        return Firestore.firestore()
    }
    public static func GetCollection(collectionName:String) -> CollectionReference {
        return GetDBReference().collection(collectionName)
    }
    public static func GetDocument(collectionName:String, documentName:String) -> DocumentReference {
        return GetCollection(collectionName: collectionName).document(documentName)
    }
}

