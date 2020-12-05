//
//  Homepage.swift
//  Grade.IO
//
//  Created by user183573 on 11/30/20.
//

import UIKit
import FSCalendar
import FirebaseAuth

class Homepage : UIViewController {
    //variable for calendar function
    @IBOutlet var calendarView:FSCalendar!
    @IBOutlet weak var signOutButton:UIButton!
    @IBOutlet weak var name:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCalendar()
        name.text = Auth.auth().currentUser?.email?.components(separatedBy: "@")[0];
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