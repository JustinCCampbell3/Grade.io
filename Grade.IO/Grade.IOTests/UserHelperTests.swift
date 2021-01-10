//
//  Grade_IOUITests.swift
//  Grade.IOUITests
//
//  Created by user183542 on 11/22/20.
//

import XCTest

var user = BaseUser()

class DBHelperTests: XCTestCase {

    override class func setUp() {
        user.FirstName = "Matt"
        user.LastName = "Gibbs"
        user.Bio = "I was born on a freight train"
        user.Email = "mattgibbs19@gmail.com"
        UserHelper.SetCurrentUser(newUser:user)
    }
    
    func testGetFullName()  {
        let generatedUserName = "Matt Gibbs"
        XCTAssertEqual(generatedUserName, UserHelper.GetFullName(user:user))
    }
    
    func testGenerateUsername() {
        XCTAssertEqual(UserHelper.GenerateUserName(), "GibbsMat")
    }
}
