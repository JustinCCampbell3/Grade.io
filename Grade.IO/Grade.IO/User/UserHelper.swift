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
    public static func GenerateUserName(firstName:String, lastName:String, type:String, completion:@escaping (String) -> Void) {

        var indexFirstName = FIRST_NAME_INDEX_DEFAULT
        var indexLastName = LAST_NAME_INDEX_DEFAULT
        var generatedName = String(lastName.prefix(indexLastName) + firstName.prefix(indexFirstName)).lowercased()
        var shouldGenerateNewName = false
        generatedName = type.first?.lowercased() as! String + "_" + generatedName
        DatabaseHelper.GetDBReference().collection(type).document(generatedName).getDocument() { res,err in
            if (err != nil) {
                completion(generatedName)
            }
            else {
                if (res?.exists == true) {
                    let number = Int.random(in: 0...1000)
                    generatedName.append(String(describing: number))
                }
                
                completion(generatedName)
            }
        }
        
    }
    
    // TODO: There is a way to deserialize to custom class instances
    public static func GetStudentByID(id:String, isTempCode:Bool = false, completion: @escaping (Student) -> ()) {
        var tempuser = Student()
        DatabaseHelper.GetDocument(collectionName: Strings.STUDENT, documentName: id) { res in
            if (isTempCode && (id.first != "x")) {
                completion(Student())
            }
            GetUserHelper(res: res as! [String:Any], tempuser: tempuser)
            tempuser.id = id
            completion(tempuser)
        }
    }
    
    // TODO Customize this function to more specifically set parent class.
    // btw: we can have a function that calls like, three functions that each take a
    // res, and builds it in each function (base user properties + extra properties from given class)
    public static func GetParentByID(id:String, completion: @escaping (Parent) -> ()) {
        DatabaseHelper.GetDocsFromKeyValues(collection: Strings.PARENT, key: Strings.ID, values: [id]) {
            res in
            if (!res.isEmpty)
            {
                var parent = Parent(dictionary: res[0].data())
                completion(parent!)
            }
            completion(Parent())
        }
    }
    public static func GetAdultHelper(res:[String:Any], tempuser:BaseAdult) {
        tempuser.email = (res as [String:Any])[Strings.EMAIL] as! String
        tempuser.phoneNumber = (res as [String:Any])[Strings.PHONE] as! String
    }
    public static func GetUserHelper(res:[String:Any], tempuser:BaseUser) {
        tempuser.firstName = (res as [String:Any])[Strings.FIRST_NAME] as! String
        tempuser.lastName = (res as [String:Any])[Strings.LAST_NAME] as! String
    }
    
    // same as above
    public static func GetTeacherByID(id:String, completion: @escaping (Teacher) -> ()) {
        var tempuser = Teacher()
        DatabaseHelper.GetDocument(collectionName: Strings.TEACHER, documentName: id) { res in
            tempuser.firstName = (res as! [String:Any])[Strings.FIRST_NAME] as! String
            tempuser.lastName = (res as! [String:Any])[Strings.LAST_NAME] as! String
            tempuser.email = (res as! [String:Any])[Strings.EMAIL] as! String
            tempuser.phoneNumber = (res as! [String:Any])[Strings.PHONE] as! String
            tempuser.id = id
            completion(tempuser)
        }
    }
    
    public static func GetUserByID(id:String, isTempCode:Bool = false, completion:@escaping(IUser) -> ()) {
        switch id.first {
        case "p":
            return GetParentByID(id:id) { (res) in
                completion(res)
            }
        case "s", "x":
            return GetStudentByID(id: id, isTempCode:isTempCode) { res in
                completion(res)
            }
        case "t":
            return GetTeacherByID(id: id) { res in
                completion(res)
            }
        default:
            completion(BaseUser())
       }
    }
}

