//
//  BaseUser.swift
//  Grade.IO
//
//  Created by matt on 1/9/21.
//

import Foundation

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
}
