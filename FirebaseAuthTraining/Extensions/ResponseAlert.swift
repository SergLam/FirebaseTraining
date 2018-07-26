//
//  ResponseAlert.swift
//  FirebaseAuthTraining
//
//  Created by Serg Liamthev on 7/26/18.
//  Copyright © 2018 SergLam. All rights reserved.
//

import UIKit
import SCLAlertView

extension SCLAlertView{
    
    func showResponseError(error: NSError) {
        SCLAlertView().showError("Error", subTitle: error.localizedDescription) // Error
//        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }
}
