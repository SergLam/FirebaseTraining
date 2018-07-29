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
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn

class EntranceVM: NSObject, GIDSignInUIDelegate, GIDSignInDelegate {
    
    static let sharedInstance = EntranceVM()
    
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
        // TODO: restore password via firebase
        let vc = UIApplication.topViewController()!
        Auth.auth().sendPasswordReset(withEmail: email){ error in
            if let error = error{
                vc.showError(error: error.localizedDescription)
            } else{
                SCLAlertView().showSuccess("Restore password", subTitle: "An email has been sent", closeButtonTitle: "OK")
            }
        }
    }
    
    func signUpViaFB(){
        let loginManager = FBSDKLoginManager()
        let vc = UIApplication.topViewController()!
        loginManager.logIn(withReadPermissions: ["public_profile", "email"], from: vc){ (result, error) in
            //if we have an error display it and abort
            if let error = error {
                vc.showError(error: error.localizedDescription)
                return
            }
            //make sure we have a result, otherwise abort
            guard let result = result else {
                vc.showError(error: "Facebook Autorization - unable to get result")
                return
            }
            //if cancelled nothing todo
            if result.isCancelled {
                vc.showError(error: "Facebook Autorization canceled by user")
                return
            }
            // Firebase redirect
            guard let accessToken = FBSDKAccessToken.current() else {
                print("Failed to get access token")
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            
            // Perform login by calling Firebase APIs
            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                if let error = error {
                    vc.showError(error: "Firebase Autorization error")
                    return
                }
                vc.showSucces(data: ["user" : authResult?.user.displayName ?? "default_name", "email" : authResult?.user.email ?? "default_email"])
            }
        }
    }
    
    // MARK: GIDSignInUIDelegate methods
    // Implement these methods only if the GIDSignInUIDelegate is not a subclass of
    // UIViewController.
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        //myActivityIndicator.stopAnimating()
    }
    
    // Present a view that prompts the user to sign in with Google
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        print("present")
        viewController.present(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        print("dismiss")
        viewController.dismiss(animated: true, completion: nil)
    }
    
    // MARK: GIDSignIn.sharedInstance().delegate methods
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        let vc = UIApplication.topViewController()!
        if let error = error {
            vc.showError(error: error.localizedDescription)
        } else {
            guard let authentication = user.authentication else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                           accessToken: authentication.accessToken)
            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                if let error = error {
                    vc.showError(error: error.localizedDescription)
                    return
                } else {
                    // Perform any operations on signed in user here.
                    let userId = user.userID ?? "default_id"                  // For client-side use only!
                    let idToken = user.authentication.idToken ?? "default_token"// Safe to send to the server
                    let fullName = user.profile.name ?? "default_token"
                    let givenName = user.profile.givenName ?? "default_given_name"
                    let familyName = user.profile.familyName ?? "default_family_name"
                    let email = user.profile.email ?? "default_email"
                    let params = ["userId":userId, "fullName": fullName, "givenName": givenName, "familyName": familyName, "email": email]
                    vc.showSucces(data: params)
                }
            }
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
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
    
    // Description: Should contains at least one digit, lower case letter, upper case letter and should contains at least 8 symbols
    func validatePassword(pass: String?) -> Bool {
        if let pass = pass{
            let regExp = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{8,100}$"
            let emailPredicate = NSPredicate(format:"SELF MATCHES %@", regExp)
            return emailPredicate.evaluate(with: pass)
        } else {
            return false
        }
    }
    
    func isEmptyString(_ str: String?) -> Bool{
        if let string = str, !string.isEmpty{
            return true
        } else{
            return false
        }
    }
    
    // MARK: Validate new user data
    
    func validateInputs(user: UserModel) -> (Bool, String) {
        let isEmail = self.validateEmail(email: user.email)
        let isPassword = self.validatePassword(pass: user.password)
        let isFirtsName = self.isEmptyString(user.firstName)
        let isSecondName = self.isEmptyString(user.secondName)
        let results = [isEmail, isPassword, isFirtsName, isSecondName]
        let is_success = isEmail && isPassword && isFirtsName && isSecondName
        switch is_success {
        case true:
            return (true, "All OK")
        case false:
            for (index, value) in results.enumerated(){
                switch index{
                case 0:
                    if(value == false){
                        return (false, "Invalid email")
                    }
                case 1:
                    if(value == false){
                        return (false, "Invalid password - Should contains at least one digit, lower case letter, upper case letter and should contains at least 8 symbols")
                    }
                case 2:
                    if(value == false){
                        return (false, "Empry first name")
                    }
                case 3:
                    if(value == false){
                        return (false, "Empry second name")
                    }
                default:
                    break
                }
            }
        }
        return (true, "All OK")
    }
        
}
