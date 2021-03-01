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
    var id : String? { get set }
    var firstName : String? { get set }
    var lastName : String? { get set }
    var email : String? { get set }
    var bio : String? { get set }
    var photoPath: String? { get set }
    var pronouns:String? { get set }
    var userType:String? { get set }
    
    func SetFirstName(newFirstName:String)
    func SetLastName(newLastName:String)
    func SetEmail(newEmail:String)
    func SetBio(newBio:String)
    func SetPhotoPath(newPhotoPath:String)
    func SetPronouns(newPronouns:String)
    
    
}
