//
//  Storage.swift
//  Grade.IO
//
//  Created by user183542 on 2/17/21.
//

import Foundation
import FirebaseStorage

public class StorageHelper {
    public static func CSVParse(fromFile:String, completion: @escaping ([Problem])->()) {
        let storage = Storage.storage()

        // Create a storage reference from our storage service
        let pathReference = storage.reference(withPath: fromFile)
        var problems:[Problem] = []

        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        pathReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
          if let error = error {
            // Uh-oh, an error occurred!
            print(error)
            completion(problems)
          }
          else {
            // Data for file @ fromFile is returned
            let string = String(data:data!, encoding: .utf8)
            let substr = string?.components(separatedBy: "\r\n")
            for component in substr! {
                let temp = component.components(separatedBy: ",")
                problems.append(Problem(Question: temp[0], Answer: temp[1]))
            }
            completion(problems)
          }
        }
    }
}
