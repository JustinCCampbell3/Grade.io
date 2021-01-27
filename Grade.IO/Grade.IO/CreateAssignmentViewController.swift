//
//  CreateAssignmentViewController.swift
//  Grade.IO
//
//  Created by user183573 on 1/26/21.
//
import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

class CreateAssignmentViewController: UIViewController, UIDocumentPickerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //allows func to be added to a button so that when its clicked the file picker will be brought up
    @IBAction func selectFiles(){
        //we only want to accept csv file extension types
        let types = UTType.types(tag: "csv", tagClass: UTTagClass.filenameExtension, conformingTo: nil)
        //this is where we make sure it only opens csv files
        let documentPickerController = UIDocumentPickerViewController(forOpeningContentTypes: types)
        //delegate it to itself
        documentPickerController.delegate = self
        //show the document pick controller (file app)
        self.present(documentPickerController, animated: true, completion: nil)
    }

}
