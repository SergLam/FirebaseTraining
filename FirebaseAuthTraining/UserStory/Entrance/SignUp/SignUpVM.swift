//
//  SignUpVM.swift
//  FirebaseAuthTraining
//
//  Created by Serg Liamthev on 7/26/18.
//  Copyright © 2018 SergLam. All rights reserved.
//

import Foundation
import FirebaseAuth
import SCLAlertView

class SignUpVM {
    
    func signUp(email: String, password: String, completion: @escaping (Bool) -> () ){
            Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                if let firebaseError = error{
                    SCLAlertView().showResponseError(error: firebaseError as NSError)
                    completion(false)
                    return
                }
                
                guard let user = authResult else {
                    SCLAlertView().showError("Error", subTitle: "Something went wrong")
                    completion(false)
                    return
                }
                SCLAlertView().showInfo("User created", subTitle: email) // Info
                completion(true)
            }
    }
    
}
