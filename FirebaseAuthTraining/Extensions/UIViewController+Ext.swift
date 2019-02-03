//
//  ResponseAlert.swift
//  FirebaseAuthTraining
//
//  Created by Serg Liamthev on 7/26/18.
//  Copyright © 2018 SergLam. All rights reserved.
//

import UIKit
import SCLAlertView

extension UIViewController{
    
    func showError(error: String) {
        SCLAlertView().showError("Error", subTitle: error, closeButtonTitle: "OK")
    }
    
    func showSucces(data: [String: Any]){
        var message = ""
        for (index, value) in data.enumerated() {
            message = message + value.key + " : " + String.init(describing: value.value) + "\n"
        }
        SCLAlertView().showSuccess("Success", subTitle: message, closeButtonTitle: "OK")
    }
    
    func hideKeyboardOnTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:    #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func hideNavBar(_ isHidden: Bool){
        self.navigationController?.setNavigationBarHidden(isHidden, animated: true)
    }
}
