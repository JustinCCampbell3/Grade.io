//
//  UserHelper.swift
//  Grade.IO
//
//  Singleton pattern more or less implemented here. CurrentUser is the equivalent of a singleton instance.
//
//  Created by matt on 1/9/21.
//

import FirebaseFirestore

public var CurrentUser:IUser = BaseUser()

var FIRST_NAME_INDEX_DEFAULT = 3
var LAST_NAME_INDEX_DEFAULT = 5

public class UserHelper {
    static var stuff = true
    
    public static func SetCurrentUser (newUser:BaseUser) {
        CurrentUser = newUser
    }
    public static func UserNameExists(name:String, type:String, delegate: @escaping (Bool) -> Void ) {
        DatabaseHelper.GetDocument(collectionName: type, documentName: name) { res in
            delegate(res?.isEmpty == true)
        }
    }
    public static func GenerateUserName(user:BaseUser, type:String, completion:@escaping (String) -> Void) -> String {
        var indexFirstName = FIRST_NAME_INDEX_DEFAULT
        var indexLastName = LAST_NAME_INDEX_DEFAULT
        var generatedName = String(user.LastName.prefix(indexLastName) + user.FirstName.prefix(indexFirstName))
        var shouldGenerateNewName = false
        while (shouldGenerateNewName)
        {
            UserNameExists(name: generatedName, type:type) { exists in
                if (exists) {
                    
                }
                else {
                    shouldGenerateNewName = false
                }
            }
        }
        
       //         {
       //             // S_GibbsMat user.ID = String(user.LastName.prefix(indexLastName) + user.FirstName.prefix(indexFirstName + 1))
       //         }
       //         else {
       //         }
      // }
        
        return generatedName
    }
    
    // TODO: There is a way to deserialize to custom class instances
    public static func GetStudentByID(id:String, completion: @escaping (Student) -> ()) {
        var tempuser = Student()
        DatabaseHelper.GetDocument(collectionName: "Student", documentName: id) { res in
            tempuser.Bio = (res as! [String:Any])["Bio"] as! String
            tempuser.FirstName = (res as! [String:Any])["FirstName"] as! String
            tempuser.LastName = (res as! [String:Any])["LastName"] as! String
            tempuser.Email = (res as! [String:Any])["Email"] as! String
            tempuser.ID = id
            completion(tempuser)
        }
    }
    
    // TODO Customize this function to more specifically set parent class.
    // btw: we can have a function that calls like, three functions that each take a
    // res, and builds it in each function (base user properties + extra properties from given class)
    public static func GetParentByID(id:String, completion: @escaping (Parent) -> ()) {
        var tempuser = Parent()
        DatabaseHelper.GetDocument(collectionName: "Student", documentName: id) { res in
            //tempuser.Bio = (res as! [String:Any])["Bio"] as! String
            //tempuser.FirstName = (res as! [String:Any])["FirstName"] as! String
            //tempuser.LastName = (res as! [String:Any])["LastName"] as! String
            //tempuser.Email = (res as! [String:Any])["Email"] as! String
            //tempuser.ID = id
            completion(tempuser)
        }
    }
    
    // same as above
    public static func GetTeacherByID(id:String, completion: @escaping (Teacher) -> ()) {
        var tempuser = Teacher()
        DatabaseHelper.GetDocument(collectionName: "Student", documentName: id) { res in
            tempuser.Bio = (res as! [String:Any])["Bio"] as! String
            tempuser.FirstName = (res as! [String:Any])["FirstName"] as! String
            tempuser.LastName = (res as! [String:Any])["LastName"] as! String
            tempuser.Email = (res as! [String:Any])["Email"] as! String
            tempuser.ID = id
            completion(tempuser)
        }
    }
    
    public static func GetUserByID(type:EUserType, id:String, completion:@escaping(IUser) -> ()) {
        switch type {
        case EUserType.Parent:
            return GetParentByID(id:id) { (res) in
                completion(res)
            }
        case EUserType.Student:
            return GetStudentByID(id: id) { res in
                completion(res)
            }
        
        case EUserType.Teacher:
            return GetTeacherByID(id: id) { res in
                completion(res)
            }
        default:
            completion(BaseUser())
       }
    }
}

