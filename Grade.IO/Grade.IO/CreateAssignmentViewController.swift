//
//  CreateAssignmentViewController.swift
//  Grade.IO
//
//  Created by user183573 on 1/26/21.
//
import UIKit
import MobileCoreServices
import UniformTypeIdentifiers
import Firebase

class CreateAssignmentViewController: UIViewController, UIDocumentPickerDelegate{
    //variables for the text fields found on this page
    @IBOutlet weak var assignName: UITextField!
    @IBOutlet weak var assignDueDate: UITextField!
    @IBOutlet weak var assignInstructions: UITextView!
    
    //variable for the label that will hold the name of the file uploaded
    @IBOutlet weak var fileNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //allows func to be added to a button so that when its clicked the file picker will be brought up
    @IBAction func selectFiles(){
        //we only want to accept csv file extension types
        let types = UTType.types(tag: "csv", tagClass: UTTagClass.filenameExtension, conformingTo: nil)
        //this is where we make sure it only opens csv files
        let documentPickerController = UIDocumentPickerViewController(forOpeningContentTypes: types)
        //delegate it to itself
        documentPickerController.delegate = self
        //only let them pick one thing
        documentPickerController.allowsMultipleSelection = false;
        //show the document pick controller (file app)
        self.present(documentPickerController, animated: true, completion: nil)
    }
    
    //when the document has been picked, this is what we want it to do with it
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print("inside didPickDocumentsAt")
        print(urls)
        
        
        
        //creation of an alert to show the user that their document was uploaded
        let fileAlert = UIAlertController(title: "Completed", message: "File has been successfully uploaded", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: {(action) -> Void in print("ok button pressed")})
        fileAlert.addAction(ok)
        
        //create a variable for the storage we are referencing in Firebase
        let bucket = Storage.storage().reference()
        
        //throw the url/file to the firebase storage we have
        bucket.child((urls.first?.deletingPathExtension().lastPathComponent)!).putFile(from: urls.first!, metadata: nil){ (_, err) in
            
            //if there's an error, print the reason
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            
            print("success")
            
            //get the name of the file imported
            let fileNameURL: String? = urls.first?.lastPathComponent
            //change the label text to the name of the file we got
            self.fileNameLabel.text = fileNameURL!

            
            //if the file successfully was pushed to the storage, then present the popup
            self.present(fileAlert, animated: true, completion: nil)
        }
        
    }
    
    //if the user cancels out of the document picker, then dismiss the controller
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("Document picker cancelled")
        //dismiss the document picker controller (file app)
        controller.dismiss(animated: true, completion: nil)
    }
    
    //when the confirm button is clicked, grab the text from the text fields, throw it to the database
    //figure out how to get this and the uploaded file to then be grabbed together later
    @IBAction func confirmQuizCreation(){
        print("label name before: " + fileNameLabel.text!)
        //check if any field is empty, and if so, don't let them do any of the below
        if(assignName.text!.isEmpty || assignDueDate.text!.isEmpty || assignInstructions.text!.isEmpty || fileNameLabel.text!.isEmpty ){
            //create an alert that tells the user they must fill out all fields
            let emptyFieldsAlert = UIAlertController(title: "Empty", message: "All fields must filled, and a file with an accepted type uploaded, to confirm assignment creation", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default, handler: {(action) -> Void in print("ok button pressed")})
            emptyFieldsAlert.addAction(ok)
            self.present(emptyFieldsAlert, animated: true, completion: nil)
        }
        else{
            //grabbing the text of the assignment name text field
            let assignNameText: String? = assignName.text
            print("Assignment Name: " + assignNameText!)
            
            //grabbing the text of the assignment name text field
            let assignDueDateText: String? = assignDueDate.text
            print("Assignment Due Date: " + assignDueDateText!)
            
            //grabbing the text of the assignment name text field
            let assignInstructionText: String? = assignInstructions.text
            print("Assignment Instructions: " + assignInstructionText!)
            
            //grabbing the text of the assignment file uploaded so it can be found later
            let fileNameLabelText: String? = fileNameLabel.text
            print("File Name from Label: " + fileNameLabelText!)
            
            //put all text fields and labels back to empty
            assignName.text = ""
            assignDueDate.text = ""
            assignInstructions.text = ""
            fileNameLabel.text = ""
            
            //put a popup that lets them know their file was created
            let assignCreatedAlert = UIAlertController(title: "Created", message: "Your assignment was created", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default, handler: {(action) -> Void in print("ok button pressed")})
            assignCreatedAlert.addAction(ok)
            self.present(assignCreatedAlert, animated: true, completion: nil)
            
            //in here you can now do whatever you need to do for grabbing the assignment information
            //the fileNameLabelText is there because I thought it would help when trying to find the necessary file in storage
            
        }
        
        
    }

}
