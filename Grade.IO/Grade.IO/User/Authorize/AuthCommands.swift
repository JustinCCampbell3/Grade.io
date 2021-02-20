//
//  Commands.swift
//  Grade.IO
//
//  Created by user183542 on 11/29/20.
//

import FirebaseAuth

public class AuthCommands
{
    static func signOutWithErrorCatch() {
        do {
            try Auth.auth().signOut()
        }
        catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    static func createUserWithEmail(email: String, password: String, completion:@escaping (Bool)->()) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if (error != nil) {
                completion(false)
            }
            else {
                completion(true)
            }
        }
    }
    static func passwordsAreSame(password:String, confirm:String) -> Bool {
        return password == confirm
    }
    static func passwordsAreValid(password:String, confirm:String) -> Bool {
        var longEnough = password.count > 7
        return passwordsAreSame(password: password, confirm: confirm) && longEnough
    }
    static func passwordOK(password:String, confirm:String) -> Bool {
        return passwordsAreValid(password: password, confirm: confirm) && passwordsAreSame(password: password, confirm: confirm)
    }
}

