//
//  Classroom.swift
//  Grade.IO
//
//  Created by user183542 on 1/17/21.
//  01.26.2021: MW worked on building out the initialization.

import Foundation
import FirebaseFirestore

var currentClassroom = Classroom()

public class Classroom : Encodable, Decodable, IListenable {
    
    public var id: String?
    public var teacherID: String?
    //list of Student ID's.
    public var studentIDs: [String]?
    public var students: [Student]?
    //list of AssignmentID's
    public var assignmentIDs: [String]?
    public var assignments:[Assignment]?
    public var name: String?
    //tuple to keep the zoom link and the corresponding image.
    //public var MeetingInfo: [(Zoom: String, Image: String)]
    public var meetingInfo: [String:String]?

    public init() {
        id = ""
        teacherID = ""
        studentIDs = []
        assignmentIDs = []
        name = ""
        meetingInfo = [:]
    }
    
    public func SetTeacherID(newTeacherID: String) {
        DatabaseHelper.SavePropertyToDatabase(collection: Strings.CLASS, document: Strings.TEACHER_ID, key: Strings.TEACHER_ID, value: newTeacherID)
    }
    public func setStudents(newStudents: [String]){
        DatabaseHelper.SavePropertyToDatabase(collection: Strings.CLASS, document: Strings.STUDENT_IDS, key: Strings.STUDENTS, value: newStudents)
    }
    public func setAssignments(newAssignments: [String]){
        DatabaseHelper.SavePropertyToDatabase(collection: Strings.CLASS, document: Strings.ASSIGNMENT_IDS, key: Strings.ASSIGNMENT, value: newAssignments)
    }
    public func SetName(newName: String) {
        DatabaseHelper.SavePropertyToDatabase(collection: Strings.CLASS, document: Strings.NAME, key: Strings.NAME, value: newName)
    }
    public func setMeetingInfo(newMeetingInfo: [String]){
        DatabaseHelper.SavePropertyToDatabase(collection: Strings.CLASS, document: Strings.MEETING_INFO, key: Strings.TEACHER_ID, value: newMeetingInfo)
    }
    public func AddAssignment(newAssignment:String)
    {
        self.assignmentIDs!.append(newAssignment)
        setAssignments(newAssignments: assignmentIDs!)
    }
    public func AddStudent(newStudent:String)
    {
        self.studentIDs!.append(newStudent)
        setStudents(newStudents: studentIDs!)
    }
    public func GetStudentObjects(completion:@escaping ([Student]) -> ()) {
        DatabaseHelper.StudentsFromKeyValue(key: Strings.CLASS_ID, value: self.id!) { res in
            self.students = res
            completion(res)
        }
    }
    public func GetAssignmentObjects(completion:@escaping ([Assignment]) -> ()) {
        DatabaseHelper.AssignmentsFromKeyValue(key: Strings.CLASS_ID, value: self.id!) { res in
            self.assignments = res
            completion(res)
        }
    }
    public func Listen() {
        DatabaseHelper.GetDBReference().collection(Strings.CLASS).document(id!).addSnapshotListener(){
                (snapshot, error) in self.SetPropertiesFromDoc(doc: snapshot!)
            }
    }
    public func SetPropertiesFromDoc(doc:DocumentSnapshot)
    {
        if let teacherID = doc.get(Strings.TEACHER_ID) {
            self.teacherID = teacherID as! String
        }
        if let students = doc.get(Strings.STUDENTS) {
            self.studentIDs = students as! [String]
        }
        if let assignments = doc.get(Strings.ASSIGNMENT) {
            self.assignmentIDs = assignments as! [String]
        }
        if let name = doc.get(Strings.NAME) {
            self.name = name as! String
        }
        if let name = doc.get(Strings.NAME) {
            self.name = name as! String
        }
        if let meetingInfo = doc.get(Strings.MEETING_INFO) {
            self.meetingInfo = meetingInfo as! [String:String]
        }
    }
}
