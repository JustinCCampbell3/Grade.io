//
//  UserHelper.swift
//  Grade.IO
//
//  Singleton pattern more or less implemented here. CurrentUser is the equivalent of a singleton instance.
//
//  Created by matt on 1/9/21.
//

import FirebaseFirestore

public var CurrentUser = BaseUser()

var FIRST_NAME_INDEX_DEFAULT = 3
var LAST_NAME_INDEX_DEFAULT = 5

public class UserHelper {
    static var stuff = true
    
    public static func SetCurrentUser (newUser:BaseUser) {
        CurrentUser = newUser
    }
    public static func UserNameExists(name:String, delegate: @escaping (Bool) -> Void ) {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        DatabaseHelper.GetDocument(collectionName: "Student", documentName: name).getDocument(){ (snap, err) in
            stuff = snap?.exists == true
            dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .main){}
        delegate(stuff)
    }
    public static func GenerateUserName(user:BaseUser) {
    
        var indexFirstName = FIRST_NAME_INDEX_DEFAULT
        var indexLastName = LAST_NAME_INDEX_DEFAULT
        user.ID = String(user.LastName.prefix(indexLastName) + user.FirstName.prefix(indexFirstName))

            UserNameExists(name: user.ID) { doet in
                if (doet)
                {
                    user.ID = String(user.LastName.prefix(indexLastName) + user.FirstName.prefix(indexFirstName + 1))
                }
                else {
                }
            
        }
    }
    
    
    public static func GetFullName(user:BaseUser) -> String {
        return user.FirstName + " " + user.LastName
    }
}
