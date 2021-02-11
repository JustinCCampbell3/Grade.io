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
    //public var MeetingInfo: [(Zoom: String, Image: String)]
    public var MeetingInfo: [String]

    public init() {
        ClassroomID = ""
        TeacherID = ""
        Students = ["", ""]
        Assignments = ["", ""]
        Name = ""
        MeetingInfo = ["", ""]
    }
    
    public func SetClassroomID(newClassroomID: String) {
        DatabaseHelper.GetDocumentReference(collectionName: "Class", documentName: "classID").setData([
            Strings.CLASS_ID : newClassroomID
            ], merge: true
        )
    }
    public func SetClassroomID(newTeacherID: String) {
        DatabaseHelper.GetDocumentReference(collectionName: "Class", documentName: "teacherID").setData([
            Strings.TEACHER_ID : newTeacherID
            ], merge: true
        )
    }
    func setStudents(newStudents: [String]){
        DatabaseHelper.GetDocumentReference(collectionName: "Class", documentName: Strings.STUDENT_ID).setData([
            Strings.STUDENT_ID : newStudents
            ], merge: true
        )
    }
    func setAssignments(newAssignments: [String]){
        DatabaseHelper.GetDocumentReference(collectionName: "Class", documentName: Strings.ASSIGNMENT_ID).setData([
            Strings.ASSIGNMENT_ID : newAssignments
            ], merge: true
        )
    }
    public func SetName(newName: String) {
        DatabaseHelper.GetDocumentReference(collectionName: "Class", documentName: "className").setData([
            Strings.NAME : newName
            ], merge: true
        )
    }
    func setMeetingInfo(newMeetingInfo: [String]){
        DatabaseHelper.GetDocumentReference(collectionName: "Class", documentName: Strings.MEETING_INFO).setData([
            Strings.MEETING_INFO : newMeetingInfo
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
        self.ClassroomID = doc.get(Strings.CLASS_ID) as! String
        self.TeacherID = doc.get(Strings.TEACHER_ID) as! String
        self.Students = doc.get(Strings.STUDENT_ID) as! [String]
        self.Assignments = doc.get(Strings.ASSIGNMENT_ID) as! [String]
        self.Name = doc.get(Strings.NAME) as! String
        self.MeetingInfo = doc.get(Strings.MEETING_INFO) as! [String]

        print("Hi there!")
    }

}
