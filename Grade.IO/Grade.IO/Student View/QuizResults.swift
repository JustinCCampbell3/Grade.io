//
//  QuizResults.swift
//  Grade.IO
//
//  Created by Justin Campbell on 4/16/21.
//

import Foundation

import UIKit

class QuizResults: UIViewController {
    
    @IBOutlet weak var TotalScore: UILabel!
    
    override func viewDidLoad() {
        TotalScore.text = finalQuizGrade
    }
    
}
