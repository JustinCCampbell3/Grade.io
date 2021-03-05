//
//  BaseUser.swift
//  Grade.IO
//
//  Created by user183542 on 1/17/21.
//

import FirebaseFirestore

public class BaseUser : IUser, Encodable, Decodable {
    public var id: String?
    public var firstName: String?
    public var lastName: String?
    public var email: String?
    public var bio: String?
    public var photoPath: String?
    public var pronouns: String?
    public var userType: String?
    
    public init() {
        id = ""
        firstName = ""
        lastName = ""
        email = ""
        bio = ""
        photoPath = ""
        pronouns = ""
        userType = ""
    }
    
    required public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decodeIfPresent(String.self, forKey: .id)
            firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
            lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
            email = try container.decodeIfPresent(String.self, forKey: .email)
            bio = try container.decodeIfPresent(String.self, forKey: .bio)
            photoPath = try container.decodeIfPresent(String.self, forKey: .photoPath)
            pronouns = try container.decodeIfPresent(String.self, forKey: .pronouns)
            userType = try container.decodeIfPresent(String.self, forKey: .userType)
    }
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(firstName, forKey: .firstName)
            try container.encode(lastName, forKey: .lastName)
            try container.encode(email, forKey: .email)
            try container.encode(bio, forKey: .bio)
            try container.encode(photoPath, forKey: .photoPath)
            try container.encode(pronouns, forKey: .pronouns)
        }
    
    public func SetID(newID:String)
    {
        id = newID
        DatabaseHelper.SaveUserPropertyToDoc(user: self, key:Strings.ID, value: newID)
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
    
    private func GetType() -> String {
        switch id?.first {
        case "x", "s" :
            return "Student"
        case "t" :
            return "Teacher"
        case "p" :
            return "Parent"
        default:
            return "ERROR"
        }
    }
    
    public func Listen() {
        DatabaseHelper.GetDBReference().collection(GetType()).document(id!).addSnapshotListener() { (snapshot, error) in
            self.SetPropertiesFromDoc(doc: snapshot!)
        }
    }
    
    public func SetPropertiesFromDoc(doc:DocumentSnapshot)
    {
        if let fName = doc.get(Strings.FIRST_NAME) {
            self.firstName = doc.get(Strings.FIRST_NAME) as! String
        }
        if let lName = doc.get(Strings.LAST_NAME) {
            self.lastName = doc.get(Strings.LAST_NAME) as! String
        }
        if let tempEmail = doc.get(Strings.EMAIL) {
            self.email = tempEmail as! String
        }
        if let tempBio = doc.get(Strings.BIO) {
            self.bio = tempBio as! String
        }
        if let tempPhotoPath = doc.get(Strings.PHOTO_PATH) {
            self.photoPath = tempPhotoPath as! String
        }
        if let tempPronouns = doc.get(Strings.PRONOUNS) {
            self.pronouns = tempPronouns as! String
        }
    }
    private enum CodingKeys : String, CodingKey {
        case firstName, lastName, email, bio, photoPath, pronouns, id, userType
    }
}
