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
import Moya

protocol EntranceVMDelegate: class {
    func onSignUpSucess()
    func onSignUpError(_ error: String)
    func onResetPasswordSucess()
    func onResetPasswordError(_ error: String)
}

class EntranceVM: NSObject, GIDSignInUIDelegate, GIDSignInDelegate {
    
    weak var delegate: EntranceVMDelegate?
    
    let provider = MoyaProvider<FirebaseAPI>()
    
    static let sharedInstance = EntranceVM()
    
    let defaults = UserDefaults.standard
    
    func signUp(email: String, password: String, completion: @escaping (Bool) -> () ){
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let firebaseError = error{
                SCLAlertView().showResponseError(error: firebaseError as NSError)
                completion(false)
                return
            }
            guard authResult != nil else {
                SCLAlertView().showError("Error", subTitle: "Something went wrong")
                completion(false)
                return
            }
            self.defaults.set(email, forKey: "email")
            completion(true)
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (Bool) -> ()){
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let firebaseError = error{
                SCLAlertView().showResponseError(error: firebaseError as NSError)
                return
            }
            guard let ready_user = user else {
                SCLAlertView().showError("Error", subTitle: "Something went wrong")
                return
            }
            print(ready_user.user)
            self.defaults.set(email, forKey: "email")
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
    
    func signUpViaFB(completion: @escaping (Bool) -> ()){
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
                vc.showError(error: "Failed to get access token")
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            
            // Perform login by calling Firebase APIs
            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                if let error = error {
                    vc.showError(error: "Firebase Autorization error")
                    return
                }
                self.defaults.set(authResult!.user.email!, forKey: "email")
                //                ListenerManager.sharedInstance.observeUserProfile(uid: authResult!.user.uid)
                completion(true)
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
        UIApplication.topViewController()!.present(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        print("dismiss")
        UIApplication.topViewController()!.dismiss(animated: true, completion: nil)
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
                    let userId = user.userID ?? "default_id"
                    // For client-side use only!
                    // TODO: Save user data to key chain
                    self.defaults.set(user.profile.email, forKey: "email")
                    if let rootVC = UIApplication.topViewController(){
                        rootVC.present(MainVC(), animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
    // MARK: Validate new user data
    
    func validateInputs(user: UserModel) -> (Bool, String) {
        let isEmail = user.email.isValidEmail()
        let isPassword = user.password?.isValidPassword() ?? false
        let isFirtsName = !(user.firstName?.isEmpty ?? true)
        let isSecondName = !(user.lastName?.isEmpty ?? true)
        let results = [isEmail, isPassword, isFirtsName, isSecondName]
        let is_success = isEmail && isPassword && isFirtsName && isSecondName
        switch is_success {
        case true:
            return (true, "All OK")
        case false:
            for (index, value) in results.enumerated(){
                if(value){
                    continue
                } else {
                    switch index{
                    case 0:
                        return (false, "Invalid email")
                    case 1:
                        return (false, "Invalid password - Should contains at least one digit, lower case letter, upper case letter and should contains at least 8 symbols")
                    case 2:
                        return (false, "Empry first name")
                    case 3:
                        return (false, "Empry second name")
                    default:
                        break
                    }
                }
            }
        }
        return (true, "All OK")
    }
    
}
