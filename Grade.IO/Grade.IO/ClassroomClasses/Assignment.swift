//
//  Assignment.swift
//  Grade.IO
//
//  Created by user183542 on 2/5/21.
//

import FirebaseFirestore

public struct Problem {
    public var Question:String = ""
    public var Answer:String = ""
}

public class Assignment : IListenable {
    public var Results:[Result]
    public var Problems:[String:Any]
    public var DueDate:Date
    public var ID:String
    public var ClassID:String
    public var FilePath:String
    public var Description:String
    public var Name:String
    
    public init() {
        Results = []
        Problems = [:]
        DueDate = Date.init()
        ID = ""
        ClassID = ""
        FilePath = ""
        Description = ""
        Name = ""
    }
    
    /// Given string, set due date of  assignment, with return value being success
    
    public func SetDueDate(newDate:String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        let result = dateFormatter.date(from: newDate)
        if (result != nil) {
            DatabaseHelper.SavePropertyToDatabase(collection: Strings.ASSIGNMENT, document: ID, key: Strings.DUE_DATE, value: result)
            return true
        }
        else {
            return false
        }
    }
    
    /// Generate ID of assignment. Set this variable, and then call listen, and you'll get an object full of info from the DB. (if the ID matches one in the DB)
    
    public func GenerateID() {
        let firstPart = CurrentUser.ID + "_"
        ID = firstPart + String(Int.random(in: 0...1000))
    }
    
    /// setters
    
    public func SetClassID(newClassID:String) {
        DatabaseHelper.SavePropertyToDatabase(collection: Strings.ASSIGNMENT, document: ID, key: Strings.CLASS_ID, value: newClassID)
    }
    public func SetDescription(newDescription:String) {
        DatabaseHelper.SavePropertyToDatabase(collection: Strings.ASSIGNMENT, document: ID, key: Strings.DESCRIPTION, value: newDescription)
    }
    public func SetName(newName:String) {
        DatabaseHelper.SavePropertyToDatabase(collection: Strings.ASSIGNMENT, document: ID, key: Strings.NAME, value: newName)
    }
    public func SetFilePath(newPath:String) {
        DatabaseHelper.SavePropertyToDatabase(collection: Strings.ASSIGNMENT, document: ID, key: Strings.FILE_PATH, value: newPath)
    }
    public func SetResults(newResults:[Result]) {
        DatabaseHelper.SavePropertyToDatabase(collection: Strings.ASSIGNMENT, document: ID, key: Strings.RESULTS, value: newResults)
    }
    public func SetProblems(newProblems:[Problem]) {
        DatabaseHelper.SavePropertyToDatabase(collection: Strings.ASSIGNMENT, document: ID, key: Strings.PROBLEMS, value: newProblems)
    }
    public func AddResult(newResult:Result) {
        let ref = DatabaseHelper.GetDBReference().collection(Strings.ASSIGNMENT).document(ID)
        ref.updateData([
            Strings.RESULTS : FieldValue.arrayUnion([newResult.getDictionary()])
        ])
    }
    public func AddProblem(question:String, answer:String) {
        self.Problems[question] = answer
        DatabaseHelper.SavePropertyToDatabase(collection: Strings.ASSIGNMENT, document: ID, key: Strings.PROBLEMS, value: self.Problems
        )
    }
    
    /// helpers
    
    /// Average time over all results of assignment
    
    public func GetAverageTime() -> Double {
        
        if (Results.count > 0)
        {
            var sum = 0.0
            for result in Results {
                sum += result.TimeTaken
            }
            return (sum/(Double(Results.count)))
        }
        
        return 0
    }
    
    /// Call this once to automatically keep object up to date with DB
    
    public func Listen() {
        DatabaseHelper.GetDBReference().collection(Strings.ASSIGNMENT).document(ID).addSnapshotListener() { (snapshot, error) in
            self.SetPropertiesFromDoc(doc: snapshot!)
        }
    }
    
    /// Keeps object up to date with DB. Triggered on Database update of corresponding instance
    
    public func SetPropertiesFromDoc(doc: DocumentSnapshot) {
        
        if let problems = doc.get(Strings.PROBLEMS) {
            self.Problems = problems as! [String:Any]
        }
        if let date = doc.get(Strings.DUE_DATE) {
            self.DueDate = (date as! Timestamp).dateValue()
        }
        if let classID = doc.get(Strings.CLASS_ID) {
            self.ClassID = classID as! String
        }
        if let filePath = doc.get(Strings.FILE_PATH) {
            self.FilePath = filePath as! String
        }
        if let description = doc.get(Strings.DESCRIPTION) {
            self.Description = description as! String
        }
    }

}
