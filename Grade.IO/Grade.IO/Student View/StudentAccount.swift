//
//  StudentAccount.swift
//  Grade.IO
//
//  Created by user183573 on 3/8/21.
//

import UIKit

class StudentAccount: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //first name of student
    @IBOutlet weak var firstName: UILabel!
    //last name of student
    @IBOutlet weak var lastName: UILabel!
    //student bio
    @IBOutlet weak var bio: UILabel!
    //preferred pronouns
    @IBOutlet weak var pronouns: UILabel!
    //Parent First name
    @IBOutlet weak var pName: UILabel!
    //parent last name
    //@IBOutlet weak var pLastName: UILabel!
    //parent email
    @IBOutlet weak var pEmail: UILabel!
    //parent phone number
    @IBOutlet weak var pNumber: UILabel!
    //picture for the user goes here
    @IBOutlet var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserHelper.GetStudentByID(id: CurrentUser.id!) { (stu) in
            UserHelper.GetParentByID(id: stu.parentID!) { (par) in
                self.popStudentAccount(student: stu, parent: par)
            }
        }
    }
    
    private func popStudentAccount(student: Student, parent: Parent){
        firstName.text = student.firstName
        lastName.text = student.lastName
        bio.text = student.bio
        pronouns.text = student.pronouns
        
        if checkImage(){
            imageView.image = readImage()
        }
        
        pName.text = parent.firstName! + " " + parent.lastName!
        pEmail.text = parent.email
        //pNumber.text = parent.phone
        
    }
    
    @IBAction func addUserPhoto(){
        let vc = UIImagePickerController()
         //access photo library
         vc.sourceType = .photoLibrary
         vc.delegate = self
         //when person selects photo, makes person select cropped portion of the photo
         vc.allowsEditing = true
         present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage
        //if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
        if image != nil{
            imageView.image = image
            print("image: ", image)
        }
        
        self.saveImagePng(image!)
        
        /*if let data = image?.pngData(){
            let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let path = documents.appendingPathComponent(CurrentUser.id! + "Photo.png")
            try? data.write(to: path)
            //CurrentUser.SetPhotoPath(newPhotoPath: url)
        }*/
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func documentDirectoryPath() -> URL? {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path.first
    }
    
    func saveImagePng(_ image: UIImage){
        if let png = image.pngData(), let path = documentDirectoryPath()?.appendingPathComponent(CurrentUser.id! + "Photo.png"){
            try? png.write(to: path)
        }
    }
    
    func checkImage() -> Bool{
        if let path = documentDirectoryPath(){
            let pngUrl = path.appendingPathComponent(CurrentUser.id! + "Photo.png")
            let pngImage = FileManager.default.contents(atPath: pngUrl.path)
            if pngImage != nil{
                return true
            }
            else{
                return false
            }
        }
        return false
    }
    
    func readImage() -> UIImage{
        let path = documentDirectoryPath()
        let pngUrl = path!.appendingPathComponent(CurrentUser.id! + "Photo.png")
        let pngImage = FileManager.default.contents(atPath: pngUrl.path)
        let uiImage = UIImage(data: pngImage!)
        return uiImage!
    }

}
