//
//  Grade_IOUITests.swift
//  Grade.IOUITests
//
//  Created by user183542 on 11/22/20.
//

import XCTest
import FirebaseFirestore
@testable import Grade_IO

var user = BaseUser()

class DBHelperTests: XCTestCase {

    override class func setUp() {
        user.firstName = "Matt"
        user.lastName = "Gibbs"
        user.bio = "I was born on a freight train"
        user.email = "mattgibbs19@gmail.com"
        UserHelper.SetCurrentUser(newUser:user)
    }
    
    func testGetFullName()  {
        let generatedUserName = "Matt Gibbs"
        //XCTAssertEqual(generatedUserName, UserHelper.GetFullName(user:user))
    }
    
    func testGenerateUsername() {
        //UserHelper.GenerateUserName(user:user){}
        //XCTAssertEqual(user.ID, "gibbsmat")
    }
}
