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
    public static func GetDocument(collectionName:String, documentName:String) -> DocumentReference {
        return GetCollection(collectionName: collectionName).document(documentName)
    }
}

