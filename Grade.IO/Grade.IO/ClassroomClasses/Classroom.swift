//
//  Classroom.swift
//  Grade.IO
//
//  Created by user183542 on 1/17/21.
//  01.26.2021: MW worked on building out the initialization.

import Foundation
import FirebaseFirestore

public class Classroom {
    
    public var ClassroomID: String
    public var TeacherID: String
    //list of Student ID's.
    public var Students: [String]
    //list of AssignmentID's
    public var Assignments: [String]
    public var Name: String
    //tuple to keep the zoom link and the corresponding image.
    public var MeetingInfo: [(Zoom: String, Image: String)]



    public init() {
        ClassroomID = ""
        TeacherID = ""
        Students = ["", ""]
        Assignments = ["", ""]
        Name = ""
        MeetingInfo = [("", "")]
    }
    
    //set up your students
    func setStudents(newStudents: [String]){
        DatabaseHelper.GetDocumentReference(collectionName: "Class", documentName: Strings.STUDENT_ID).setData([
            Strings.STUDENT_ID : newStudents
            ], merge: true
        )
    }
    
    public func SetName(newName: String) {
        DatabaseHelper.GetDocumentReference(collectionName: "Class", documentName: "className").setData([
            Strings.NAME : newName
            ], merge: true
        )
    }
    
    public func Listen() {
        DatabaseHelper.GetDBReference().collection("Class").document(ClassroomID).addSnapshotListener(){
                (snapshot, error) in self.SetPropertiesFromDoc(doc: snapshot!)
            }
    }
    
    public func SetPropertiesFromDoc(doc:DocumentSnapshot)
    {
        self.Name = doc.get(Strings.NAME) as! String
        
        self.Students = doc.get(Strings.STUDENT_ID) as! [String]

        print("Hi there!")
    }

}
