//
//  Classroom.swift
//  Grade.IO
//
//  Created by user183542 on 1/17/21.
//  01.26.2021: MW worked on building out the initialization.

import Foundation
import FirebaseFirestore

public class Classroom : IListenable {
    
    public var ID: String
    public var TeacherID: String
    //list of Student ID's.
    public var Students: [String]
    //list of AssignmentID's
    public var Assignments: [String]
    public var Name: String
    //tuple to keep the zoom link and the corresponding image.
    //public var MeetingInfo: [(Zoom: String, Image: String)]
    public var MeetingInfo: [String:String]

    public init() {
        ID = ""
        TeacherID = ""
        Students = []
        Assignments = []
        Name = ""
        MeetingInfo = [:]
    }
    
    public func SetTeacherID(newTeacherID: String) {
        DatabaseHelper.SavePropertyToDatabase(collection: Strings.CLASS, document: Strings.TEACHER_ID, key: Strings.TEACHER_ID, value: newTeacherID)
    }
    public func setStudents(newStudents: [String]){
        DatabaseHelper.SavePropertyToDatabase(collection: Strings.CLASS, document: Strings.TEACHER_ID, key: Strings.STUDENTS, value: newStudents)
    }
    public func setAssignments(newAssignments: [String]){
        DatabaseHelper.SavePropertyToDatabase(collection: Strings.CLASS, document: Strings.TEACHER_ID, key: Strings.ASSIGNMENT, value: newAssignments)
    }
    public func SetName(newName: String) {
        DatabaseHelper.SavePropertyToDatabase(collection: Strings.CLASS, document: Strings.TEACHER_ID, key: Strings.NAME, value: newName)
    }
    public func setMeetingInfo(newMeetingInfo: [String]){
        DatabaseHelper.SavePropertyToDatabase(collection: Strings.CLASS, document: Strings.MEETING_INFO, key: Strings.TEACHER_ID, value: newMeetingInfo)
    }
    public func AddAssignment(newAssignment:String)
    {
        self.Assignments.append(newAssignment)
        setAssignments(newAssignments: Assignments)
    }
    public func AddStudent(newStudent:String)
    {
        self.Students.append(newStudent)
        setStudents(newStudents: Students)
    }
    public func Listen() {
        DatabaseHelper.GetDBReference().collection(Strings.CLASS).document(ID).addSnapshotListener(){
                (snapshot, error) in self.SetPropertiesFromDoc(doc: snapshot!)
            }
    }
    public func SetPropertiesFromDoc(doc:DocumentSnapshot)
    {
        if let teacherID = doc.get(Strings.TEACHER_ID) {
            self.TeacherID = teacherID as! String
        }
        if let students = doc.get(Strings.STUDENTS) {
            self.Students = students as! [String]
        }
        if let assignments = doc.get(Strings.ASSIGNMENT) {
            self.Assignments = assignments as! [String]
        }
        if let name = doc.get(Strings.NAME) {
            self.Name = name as! String
        }
        if let name = doc.get(Strings.NAME) {
            self.Name = name as! String
        }
        if let meetingInfo = doc.get(Strings.MEETING_INFO) {
            self.MeetingInfo = meetingInfo as! [String:String]
        }
    }
}
