//
//  Alert.swift
//  Grade.IO
//
//  Created by user183542 on 1/19/21.
//

import Foundation
import UIKit

func DoAlert(title:String, body:String, vc:UIViewController) {
    let alert = UIAlertController(title: title, message: body, preferredStyle: .alert)

    alert.addAction(UIAlertAction(title: "okay", style: .cancel, handler: nil))

    vc.present(alert, animated: true)
}

func userNameAlert(vc:UIViewController) {
    DoAlert(title: CurrentUser.ID , body: "Your username is above. You will use it to log in. Don't forget to write it down!", vc: vc)
}


