//
//  IListenable.swift
//  Grade.IO
//
//  Created by user183542 on 2/5/21.
//

import FirebaseFirestore
public protocol IListenable {
    func Listen()
    func SetPropertiesFromDoc(doc:DocumentSnapshot)
}
