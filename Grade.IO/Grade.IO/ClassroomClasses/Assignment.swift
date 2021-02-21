//
//  Assignment.swift
//  Grade.IO
//
//  Created by user183542 on 2/5/21.
//

import FirebaseFirestore

public struct Problem : Decodable, Encodable {
    public var Question:String = ""
    public var Answer:String = ""
}

public class Assignment : Decodable, Encodable, IListenable {
    public var results:[Result]?
    public var problems:[Problem]?
    public var dueDate:Date?
    public var id:String?
    public var classID:String?
    public var filePath:String?
    public var description:String?
    public var name:String?
    
    public init() {
        results = []
        problems = []
        dueDate = Date.init()
        id = ""
        classID = ""
        filePath = ""
        description = ""
        name = ""
    }
    
    /// Given string, set due date of  assignment, with return value being success
    
    public func SetDueDate(newDate:String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        let result = dateFormatter.date(from: newDate)
        if (result != nil) {
            DatabaseHelper.SavePropertyToDatabase(collection: Strings.ASSIGNMENT, document: id!, key: Strings.DUE_DATE, value: result)
            return true
        }
        else {
            return false
        }
    }
    
    /// Generate ID of assignment. Set this variable, and then call listen, and you'll get an object full of info from the DB. (if the ID matches one in the DB)
    
    public func GenerateID() {
        //let firstPart = CurrentUser.ID + "_"
        //id = firstPart + String(Int.random(in: 0...1000))
    }
    
    /// setters
    
    public func SetClassID(newClassID:String) {
        DatabaseHelper.SavePropertyToDatabase(collection: Strings.ASSIGNMENT, document: id!, key: Strings.CLASS_ID, value: newClassID)
    }
    public func SetDescription(newDescription:String) {
        DatabaseHelper.SavePropertyToDatabase(collection: Strings.ASSIGNMENT, document: id!, key: Strings.DESCRIPTION, value: newDescription)
    }
    public func SetName(newName:String) {
        DatabaseHelper.SavePropertyToDatabase(collection: Strings.ASSIGNMENT, document: id!, key: Strings.NAME, value: newName)
    }
    public func SetFilePath(newPath:String) {
        DatabaseHelper.SavePropertyToDatabase(collection: Strings.ASSIGNMENT, document: id!, key: Strings.FILE_PATH, value: newPath)
    }
    public func SetResults(newResults:[Result]) {
        DatabaseHelper.SavePropertyToDatabase(collection: Strings.ASSIGNMENT, document: id!, key: Strings.RESULTS, value: newResults)
    }
    public func SetProblems(newProblems:[Problem]) {
        DatabaseHelper.SavePropertyToDatabase(collection: Strings.ASSIGNMENT, document: id!, key: Strings.PROBLEMS, value: newProblems)
    }
    public func AddResult(newResult:Result) {
        let ref = DatabaseHelper.GetDBReference().collection(Strings.ASSIGNMENT).document(id!)
        ref.updateData([
            Strings.RESULTS : FieldValue.arrayUnion([newResult.getDictionary()])
        ])
    }
    public func AddProblem(question:String, answer:String) {
        let washingtonRef = DatabaseHelper.GetDBReference().collection(Strings.ASSIGNMENT).document(id!)
        washingtonRef.updateData([
            Strings.PROBLEMS : FieldValue.arrayUnion([Problem(Question: question, Answer: answer).getDictionary()])
        ])
    }
    
    /// helpers
    
    /// Average time over all results of assignment
    
    public func GetAverageTime() -> Double {
        
       /* if (results.count > 0)
        {
            var sum = 0.0
            for result in results {
                sum += result.TimeTaken
            }
            return (sum/(Double(results.count)))
        }
        */
        return 0
    }
    
    /// Call this once to automatically keep object up to date with DB
    
    public func Listen() {
        DatabaseHelper.GetDBReference().collection(Strings.ASSIGNMENT).document(id!).addSnapshotListener() { (snapshot, error) in
            self.SetPropertiesFromDoc(doc: snapshot!)
        }
    }
    
    /// Keeps object up to date with DB. Triggered on Database update of corresponding instance
    
    public func SetPropertiesFromDoc(doc: DocumentSnapshot) {
        
        if let pL = doc.get(Strings.PROBLEMS) as? [[String:Any]] {
            problems = []
            for p in pL {
                var problem = Problem(dictionary: p)
                problems!.append(problem!)
            }
        }
        if let rL = doc.get(Strings.RESULTS) as? [[String:Any]] {
            results = []
            for r in rL {
                var result = Result(dictionary: r)
                results!.append(result!)
            }
        }
        if let date = doc.get(Strings.DUE_DATE) {
            self.dueDate = (date as! Timestamp).dateValue()
        }
        if let classID = doc.get(Strings.CLASS_ID) {
            self.classID = classID as! String
        }
        if let filePath = doc.get(Strings.FILE_PATH) {
            self.filePath = filePath as! String
        }
        if let description = doc.get(Strings.DESCRIPTION) {
            self.description = description as! String
        }
    }

}
