 //
//  Homepage.swift
//  Grade.IO
//
//  Created by user183573 on 11/30/20.
//

import UIKit
import FSCalendar
import FirebaseAuth
import FirebaseFirestore

class Homepage : UIViewController {
    //variable for calendar function
    @IBOutlet var calendarView:FSCalendar!
    @IBOutlet weak var signOutButton:UIButton!
    @IBOutlet weak var name:UILabel!
    @IBOutlet weak var grade: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCalendar()
        name.text = CurrentUser.id
        
        DatabaseHelper.GetClassroomFromID(classID: (CurrentUser as! Student).classID ?? "NULL") { res in
            currentClassroom = res
            currentClassroom.GetAssignmentObjects { (assign) in
                self.findGrade(assigns: assign)
            }
        }
        
        CurrentUser.SetBio(newBio: "Hello")
        
    }
    
    private func findGrade(assigns: [Assignment]){
        //var that will hold the assignments
        var listAssignments: [Assignment] = []
        
        for i in assigns {
            listAssignments.append(i)
        }
        
        var totalGrade: Float = 0
        var numAssignsTaken: Int = 0
        
        for i in listAssignments{
            let resultIndex = i.GetResultIndexByID(id: CurrentUser.id!)
            
            if(resultIndex != -1){
                let studentResult = i.results?[resultIndex]
                let percent = studentResult!.Grade
                totalGrade += percent
                print("totalGrade now: ", totalGrade)
                numAssignsTaken += 1
            }
        }
        print("num of assigns taken: ", numAssignsTaken)
        
        let avgGrade = totalGrade / Float(numAssignsTaken)
        let percentGrade = avgGrade * 100.0
        
        grade.text = String(format: "%.2f", percentGrade) + "%"
    }

    func setupCalendar(){
        calendarView.delegate = self
        calendarView.dataSource = self
    }

    @IBAction func signOutPressed(_ sender: Any) {
        do
        {
             try Auth.auth().signOut()
        }
        catch let error as NSError
        {
             print(error.localizedDescription)
        }
        performSegue(withIdentifier: "backToMenuFromHomepage", sender: self)
    }
}

//datasource extension
extension Homepage : FSCalendarDataSource{
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
}

//delegate extension
extension Homepage : FSCalendarDelegate{
    //allows user to select a date and then will run the code inside of it
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        //will hold the date and time
        let dFormatter = DateFormatter()
        dFormatter.dateFormat = "EEEE MM-dd-YYYY"
        
        //will get the string version of the date and time
        let dateString = dFormatter.string(from: date)
        print("\(dateString)")
    }}
