//
//  BaseUser.swift
//  Grade.IO
//
//  Created by matt on 1/9/21.
//

import Foundation
import FirebaseFirestore

public class BaseUser
{
    public var ID : String
    public var FirstName : String
    public var LastName : String
    public var Email : String
    public var Bio : String

    public init() {
        ID = ""
        FirstName = ""
        LastName = ""
        Email = ""
        Bio = ""
    }
    
    /// Set the FirstName property, and update the FirstName document in the database
    public func SetFirstName(newFirstName:String) {
        FirstName = newFirstName
        SaveToDoc(key:"FirstName", value:FirstName)
    }
    
    /// Set the LastName property, and update the LastName document in the database
    public func SetLastName(newLastName:String) {
        LastName = newLastName
        SaveToDoc(key:"LastName", value:LastName)
    }
    
    /// Set the Email property, and update the Email document in the database
    public func SetEmail(newEmail:String) {
        Email = newEmail
        SaveToDoc(key:"Email", value:Email)
    }
    
    /// Set the ID property, and update the ID document in the database
    public func SetID(newID:String) {
        ID = newID
        SaveToDoc(key:"ID", value:ID)
    }
    
    /// Set the Bio property, and update the Bio document in the database
    public func SetBio(newBio:String) {
        Bio = newBio
        SaveToDoc(key:"Bio", value:Bio)
    }
    
    // todo: move to DatabaseHelper? Add third (ugh) param to handle collection name? Or maybe just pass in a DocumentSnapshot
    func SaveToDoc(key:String, value:String) {
        DatabaseHelper.GetDocument(collectionName: "Student", documentName: ID).setData([
            key : value
        ], merge: true)
    }
}
