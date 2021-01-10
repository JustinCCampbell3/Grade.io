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
    public static func SetCurrentUser (newUser:BaseUser) {
        CurrentUser = newUser
    }
    public static func UserNameExists(name:String) -> Bool {
        return false;
    }
    public static func GenerateUserName() -> String {
        
        let db = DatabaseHelper.GetDBReference()

        var returnName = CurrentUser.LastName.prefix(LAST_NAME_INDEX_DEFAULT) + CurrentUser.FirstName.prefix(FIRST_NAME_INDEX_DEFAULT) 
        
        return String(returnName)
    }
    
    public static func GetFullName(user:BaseUser) -> String {
        return user.FirstName + " " + user.LastName
    }
}
