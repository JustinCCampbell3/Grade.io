//
//  TeacherAccount.swift
//  Grade.IO
//
//  Created by user183573 on 3/2/21.
//

import UIKit
import SideMenu
import TinyConstraints
import Foundation

class TeacherAccount: UIViewController, MenuControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    //variable for the slide out menu in the teacher view
    private var sideMenu: SideMenuNavigationController?
    
    @IBOutlet weak var teacherFirstName: UILabel!
    
    @IBOutlet weak var teacherLastName: UILabel!
    
    @IBOutlet weak var teacherEmail: UILabel!
    
    @IBOutlet weak var teacherNum: UILabel!
    
    @IBOutlet weak var teacherBio: UILabel!
    
    @IBOutlet weak var teacherPronouns: UILabel!
    
    //where the picture will be seen by the teacher. Can replace with the button. Have to grab pic from here
    @IBOutlet var imageView: UIImageView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //get teacher info
        UserHelper.GetTeacherByID(id: CurrentUser.id!) { (res) in
            self.populateTeacherLabels(teacher: res)
        }
        
        //creating the side menu starts here
        let menu = MenuListController()
        menu.delegate = self
        
        sideMenu = SideMenuNavigationController(rootViewController: menu)
        //setting menu to open on the left side. without this it opens on the right
        sideMenu?.leftSide = true
        //hide the white bar at the top of the side menu to make it look better
        //sideMenu?.setNavigationBarHidden(true, animated: false)
        
        
        //tell the manager which side the menu is on
        SideMenuManager.default.leftMenuNavigationController = sideMenu

    }
    
    private func populateTeacherLabels(teacher: Teacher){
        teacherFirstName.text = teacher.firstName
        teacherLastName.text = teacher.lastName
        teacherPronouns.text = teacher.pronouns
        teacherEmail.text = teacher.email
        teacherNum.text = teacher.phone
        teacherBio.text = teacher.bio
        
        if checkImage(){
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
    
    @IBAction func didTapMenu(){
        present(sideMenu!, animated: true)
    }
    
    func didSelectMenuItem(named: String) {
        
        //once menu has dismissed, go to that screen
        sideMenu?.dismiss(animated: true, completion: {
            if named == "Student List"{
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc: UINavigationController = storyBoard.instantiateViewController(withIdentifier: "TSLNav") as! UINavigationController
                //let vc: UIViewController = storyBoard.instantiateViewController(withIdentifier: "TStudentList") as! UIViewController
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated:true, completion: nil)
                //self.navigationController?.pushViewController(vc, animated: true)
                
            }
            else if named == "Assignments"{
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc: UINavigationController = storyBoard.instantiateViewController(withIdentifier: "TAsNav") as! UINavigationController
                //let vc: UIViewController = storyBoard.instantiateViewController(withIdentifier: "TAssignment") as! UIViewController
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated:true, completion: nil)
                //self.navigationController?.pushViewController(vc, animated: true)
            }
            else if named == "Files"{
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc: UINavigationController = storyBoard.instantiateViewController(withIdentifier: "TFNav") as! UINavigationController
                //let vc: UIViewController = storyBoard.instantiateViewController(withIdentifier: "TFiles") as! UIViewController
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated:true, completion: nil)
                //self.navigationController?.pushViewController(vc, animated: true)
            }
            else if named == "Account"{
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc: UINavigationController = storyBoard.instantiateViewController(withIdentifier: "TAcNav") as! UINavigationController
                //let vc: UIViewController = storyBoard.instantiateViewController(withIdentifier: "TAccount") as! UIViewController
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated:true, completion: nil)
                //self.navigationController?.pushViewController(vc, animated: true)
            }
            else if named == "Home"{
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                //let vc: UIViewController = storyBoard.instantiateViewController(withIdentifier: "THome") as! UIViewController
                let vc: UITabBarController = storyBoard.instantiateViewController(withIdentifier: "THomeTab") as! UITabBarController
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated:true, completion: nil)
                //self.navigationController?.pushViewController(vc, animated: true)
            }
        })
    }

}
