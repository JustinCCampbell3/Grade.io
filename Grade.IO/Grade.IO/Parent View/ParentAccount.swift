//
//  ParentAccount.swift
//  Grade.IO
//
//  Created by user183573 on 3/4/21.
//

import UIKit

class ParentAccount: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //the parent we want
    
    
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    //picture for the user goes here
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserHelper.GetUserByID(id: CurrentUser.id!) { (res) in
            //self.popParentInfo(parent: (res as! Parent))
            self.popParentInfo()
        }
        
    }
    

    private func popParentInfo(){
        /*
        lastName.text = parent.lastName
        firstName.text = parent.firstName
        email.text = parent.email
        phoneNumber.text = parent.phoneNumber
        */
        
        lastName.text = CurrentUser.lastName
        firstName.text = CurrentUser.firstName
        email.text = CurrentUser.email
        //phoneNumber.text = CurrentUser.phoneNumber
        
        print("checking image")
        if checkImage(){
            print("found an image")
            imageView.image = readImage()
        }
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
                print("there is an image")
                return true
            }
            else{
                print("there is no image")
                return false
            }
        }
        print("there is no path")
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
