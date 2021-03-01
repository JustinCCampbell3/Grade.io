//
//  Teacher.swift
//  Grade.IO
//
//  Created by user183542 on 1/15/21.
//

import FirebaseFirestore

public class Teacher : BaseAdult
{
    public var classID:String? = ""
    
    public override init() {
        super.init()
        userType = Strings.TEACHER
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        classID = try container.decodeIfPresent(String.self, forKey: .classID)
        try super.init(from: decoder)
    }
    
    public override func SetPropertiesFromDoc(doc: DocumentSnapshot) {
        super.SetPropertiesFromDoc(doc: doc)
        if let temp = doc.get(Strings.CLASS_ID) {
            self.classID = temp as! String
        }
    }
    
    private enum CodingKeys : String, CodingKey {
        case classID
    }
}
