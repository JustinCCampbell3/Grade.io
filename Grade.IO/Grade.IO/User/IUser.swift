//
//  BaseUser.swift
//  Grade.IO
//
//  Created by matt on 1/9/21.
//

import Foundation
import FirebaseFirestore

public protocol IUser : IListenable
{
    var ID : String { get set }
    var FirstName : String { get set }
    var LastName : String { get set }
    var Email : String { get set }
    var Bio : String { get set }
    var PhotoPath: String { get set }
    var Pronouns:String { get set }
    var UserType:EUserType { get set }
    
    func SetFirstName(newFirstName:String)
    func SetLastName(newLastName:String)
    func SetEmail(newEmail:String)
    func SetBio(newBio:String)
    func SetPhotoPath(newPhotoPath:String)
    func SetPronouns(newPronouns:String)
    
    
}
