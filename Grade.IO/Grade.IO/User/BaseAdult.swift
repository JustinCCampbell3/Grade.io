//
//  BaseAdult.swift
//  Grade.IO
//
//  Created by user183542 on 1/15/21.
//

import Foundation
public class BaseAdult : BaseUser
{
    public var PhoneNumber:String = ""
    
    public override init () {
        super.init()
    }

    public func SetPhoneNumber(newNumber:String) {
        DatabaseHelper.SaveUserPropertyToDoc(user: self, key: Strings.PHONE, value: newNumber)
    }
}

