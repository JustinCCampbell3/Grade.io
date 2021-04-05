//
//  Classroom.swift
//  Grade.IO
//
//  Created by user183542 on 1/17/21.
//  01.26.2021: MW worked on building out the initialization.

import Foundation
import FirebaseFirestore

var currentClassroom = Classroom(newID:".")

public class Classroom : Encodable, Decodable, IListenable {
    
    public var id: String?
    public var teacherID: String?
    //list of Student ID's.
    public var studentIDs: [String]?
    //list of AssignmentID's
    public var assignmentIDs: [String]?
    public var name: String?
    //tuple to keep the zoom link and the corresponding image.
    //public var MeetingInfo: [(Zoom: String, Image: String)]
    public var meetingInfo: [String:String]?

    public init(newID:String) {
        id = ""
        teacherID = ""
        studentIDs = []
        assignmentIDs = []
        name = ""
        meetingInfo = [:]
        SetID(newID: newID)
    }
    
    public func SetID(newID:String) {
        id = newID
        DatabaseHelper.SavePropertyToDatabase(collection: Strings.CLASS, document: id!, key: Strings.ID, value: newID)
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
        DatabaseHelper.SavePropertyToDatabase(collection: Strings.CLASS, document: id!, key: Strings.NAME, value: newName)
    }
    public func setMeetingInfo(newMeetingInfo: [String]){
        DatabaseHelper.SavePropertyToDatabase(collection: Strings.CLASS, document: Strings.MEETING_INFO, key: Strings.TEACHER_ID, value: newMeetingInfo)
    }
    public func AddAssignment(newAssignment:String)
    {
        self.assignmentIDs!.append(newAssignment)
        let washingtonRef = DatabaseHelper.GetDBReference().collection(Strings.CLASS).document(id!)
        washingtonRef.setData([
            Strings.ASSIGNMENT_IDS : FieldValue.arrayUnion([newAssignment])
        ], merge: true)
    }
    public func AddStudent(newStudent:String)
    {
        self.studentIDs!.append(newStudent)
        setStudents(newStudents: studentIDs!)
        DatabaseHelper.SavePropertyToDatabase(collection: Strings.STUDENT, document: newStudent, key:Strings.CLASS_ID, value: id)
        
        let washingtonRef = DatabaseHelper.GetDBReference().collection(Strings.CLASS).document(id!)

        washingtonRef.setData([
            Strings.STUDENT_IDS : FieldValue.arrayUnion([newStudent])
        ], merge: true)
    }
    
    public func GetStudentObjects(completion:@escaping ([Student]) -> ()) {
        DatabaseHelper.GetDocumentsFromIDs(collection:Strings.STUDENT, ids:studentIDs ?? []) { res in
            var tempList:[Student] = []
            for document in res {
                let tempStudent = Student(dictionary: document.data()!)
                tempStudent?.Listen()
                tempList.append(tempStudent!)
            }
            completion(tempList)
        }
    }
    public func GetAssignmentObjects(completion:@escaping ([Assignment]) -> ()) {
        DatabaseHelper.GetDocumentsFromIDs(collection:Strings.ASSIGNMENT, ids:assignmentIDs ?? []) { res in
            var tempList:[Assignment] = []
            for document in res {
                let tempAssignment = Assignment(dictionary: document.data()!)
                tempAssignment?.Listen()
                tempList.append(tempAssignment ?? Assignment(newID:"NULL"))
            }
            completion(tempList)
        }
    }
    public func GetTeacherObject(completion:@escaping (Teacher)->()) {
        UserHelper.GetUserByID(id: teacherID!) { res in
            completion(res as? Teacher ?? Teacher(id:"NULL"))
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
        if let students = doc.get(Strings.STUDENT_IDS) {
            self.studentIDs = students as! [String]
        }
        if let assignments = doc.get(Strings.ASSIGNMENT_IDS) {
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
