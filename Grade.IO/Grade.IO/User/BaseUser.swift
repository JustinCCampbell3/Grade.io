//
//  BaseUser.swift
//  Grade.IO
//
//  Created by user183542 on 1/17/21.
//

import FirebaseFirestore

public class BaseUser : IUser {
    public var ID: String
    public var FirstName: String
    public var LastName: String
    public var Email: String
    public var Bio: String
    public var PhotoPath: String
    public var Pronouns: String
    public var UserType: EUserType
    
    public init() {
        ID = ""
        FirstName = ""
        LastName = ""
        Email = ""
        Bio = ""
        PhotoPath = ""
        Pronouns = ""
        UserType = EUserType.NULL
    }
    
    public func SetFirstName(newFirstName: String) {
        DatabaseHelper.SaveUserPropertyToDoc(user: self, key:Strings.FIRST_NAME, value: newFirstName)
    }
    
    public func SetLastName(newLastName: String) {
        DatabaseHelper.SaveUserPropertyToDoc(user: self, key:Strings.LAST_NAME, value: newLastName)
    }
    
    public func SetEmail(newEmail: String) {
        DatabaseHelper.SaveUserPropertyToDoc(user: self, key:Strings.EMAIL, value: newEmail)
    }
    
    public func SetBio(newBio: String) {
        DatabaseHelper.SaveUserPropertyToDoc(user: self, key:Strings.BIO, value: newBio)
    }
    
    public func SetPhotoPath(newPhotoPath: String) {
        DatabaseHelper.SaveUserPropertyToDoc(user: self, key:Strings.PHOTO_PATH, value: newPhotoPath)
    }
    
    public func SetPronouns(newPronouns: String) {
        DatabaseHelper.SaveUserPropertyToDoc(user: self, key:Strings.PRONOUNS, value: newPronouns)
    }
    public func GetUserType() -> EUserType {
        switch ID.first {
        case "s", "x":
            return EUserType.Student
        case "p" :
            return EUserType.Parent
        case "t" :
            return EUserType.Teacher
        default:
            return EUserType.NULL
        }
    }
    
    public func Listen() {
        DatabaseHelper.GetDBReference().collection(String(describing: GetUserType())).document(ID).addSnapshotListener() { (snapshot, error) in
            self.SetPropertiesFromDoc(doc: snapshot!)
        }
    }
    
    public func SetPropertiesFromDoc(doc:DocumentSnapshot)
    {
        self.FirstName = doc.get(Strings.FIRST_NAME) as! String
        self.LastName = doc.get(Strings.LAST_NAME) as! String
        if let tempEmail = doc.get(Strings.EMAIL) {
            self.Email = tempEmail as! String
        }
        if let tempBio = doc.get(Strings.BIO) {
            self.Bio = tempBio as! String
        }
        if let tempPhotoPath = doc.get(Strings.PHOTO_PATH) {
            self.PhotoPath = tempPhotoPath as! String
        }
        if let tempPronouns = doc.get(Strings.PRONOUNS) {
            self.Pronouns = tempPronouns as! String
        }
    }
}
