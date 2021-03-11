//
//  BaseAdult.swift
//  Grade.IO
//
//  Created by user183542 on 1/15/21.
//

import Foundation
public class BaseAdult : BaseUser
{
    public var phone:String?
    
    public override init () {
        super.init()
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        phone = try container.decodeIfPresent(String.self, forKey: .phone)
        try super.init(from: decoder)
    }
    
    public func SetPhoneNumber(newNumber:String) {
        DatabaseHelper.SaveUserPropertyToDoc(user: self, key: Strings.PHONE, value: newNumber)
    }
    
    private enum CodingKeys:String, CodingKey {
        case phone
    }
}

