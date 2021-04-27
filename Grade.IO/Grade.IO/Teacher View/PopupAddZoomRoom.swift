//
//  PopupAddZoomRoom.swift
//  Grade.IO
//
//  Created by user183573 on 1/16/21.
//

import UIKit

class PopupAddZoomRoom: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //where the picture will be seen by the teacher. Can replace with the button. Have to grab pic from here
    @IBOutlet var imageView: UIImageView!
    //for the name of the zoom room
    @IBOutlet weak var zoomName: UITextField!
    //for the url associated with the zoom room
    @IBOutlet weak var zoomURL: UITextField!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //for when the "Add Picture" button was tapped
    @IBAction func didTapPicButton() {
       let vc = UIImagePickerController()
        //access photo library
        vc.sourceType = .photoLibrary
        vc.delegate = self
        //when person selects photo, makes person select cropped portion of the photo
        vc.allowsEditing = true
        present(vc, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            imageView.image = image
            print("image: ", image)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    //for clicking the confirm button
    @IBAction func confirmAddZRoom(){
        let roomName: String? = zoomName.text
        let roomURL: String? = zoomURL.text
        print("Name: ", roomName!)
        print("URL: ", roomURL!)
        
    }}
