//
//  Parent.swift
//  Grade.IO
//
//  Created by user183542 on 1/15/21.
//

import Foundation
public class Parent : BaseAdult {

    public var Students:[String] = []

    public override init() {
        super.init()
        UserType = EUserType.Parent
    }
    public func AddStudent(id:String) {
        UserHelper.GetStudentByID(id: id) { res in
            if (res != nil) {
                self.Students.append(id)
            }
            else {
                print("error")
            }
        }
    }
}
