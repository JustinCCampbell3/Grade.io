//
//  Commands.swift
//  Grade.IO
//
//  Created by user183542 on 11/29/20.
//

import FirebaseAuth

class AuthCommands
{
    static func signOutWithErrorCatch() {
        do {
            try Auth.auth().signOut()
        }
        catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        print ("Signed out successfully")
    }
}
