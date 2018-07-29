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
        for (index, value) in data.enumerated(){
            message = message + value.key + " : " + String.init(describing: value.value) + "\n"
        }
        SCLAlertView().showSuccess("Success", subTitle: message, closeButtonTitle: "OK")
    }
}

extension SCLAlertView{
    func showResponseError(error: NSError) {
        SCLAlertView().showError("Error", subTitle: error.localizedDescription, closeButtonTitle: "OK")
    }
}
