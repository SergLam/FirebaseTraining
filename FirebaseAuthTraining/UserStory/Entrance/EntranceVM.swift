//
//  EntranceVM.swift
//  FirebaseAuthTraining
//
//  Created by Serg Liamthev on 7/26/18.
//  Copyright © 2018 SergLam. All rights reserved.
//
import Foundation
import FirebaseAuth
import SCLAlertView

class EntranceVM {
    
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
    
    func signIn(email: String, password: String, completion: @escaping (Bool) -> ()){
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if let firebaseError = error{
                    SCLAlertView().showResponseError(error: firebaseError as NSError)
                    completion(false)
                    return
                }
                
                guard let user = user else {
                    SCLAlertView().showError("Error", subTitle: "Something went wrong")
                    completion(false)
                    return
                }
                SCLAlertView().showInfo("User logined", subTitle: email) // Info
                completion(true)
            }
    }
    
    func restorePassword(email: String){
        
    }
    
    // MARK: Validation functions
    
    func validateEmail(email: String?) -> Bool{
        if let email = email{
            let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
            return emailPredicate.evaluate(with: email)
        } else {
            return false
        }
    }
    
    func validatePassword(pass: String?) -> Bool {
        if let pass = pass{
            let regExp = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{8,15}$"
            let emailPredicate = NSPredicate(format:"SELF MATCHES %@", regExp)
            return emailPredicate.evaluate(with: pass)
        } else {
            return false
        }
    }
    
    func isEmptyString(_ str: String?) -> Bool{
        if let string = str{
            return string.isEmpty
        } else{
            return false
        }
    }
    
    
    
}
