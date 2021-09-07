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

protocol EntranceVMDelegate: AnyObject {
    func onSignUpSucess(_ auth: AuthDataResult)
    func onSignUpError(_ error: String)
    func onResetPasswordSucess()
    func onResetPasswordError(_ error: String)
}

enum EntranceError: Error {
    case emptyField(fieldName: String)
    case invalidPassword
    case invalidEmail
    
    var description: String {
        switch self {
        case .invalidPassword:
            return Localizable.errorInvalidPassword()
        case .invalidEmail:
            return Localizable.errorInvalidEmail()
        case .emptyField(let fieldName):
            return Localizable.errorEmptyField(fieldName)
        }
    }
}

final class EntranceVM: NSObject, GIDSignInDelegate {
    
    weak var delegate: EntranceVMDelegate?
    
    let provider = MoyaProvider<FirebaseAPI>()
    
    static let sharedInstance = EntranceVM()
    
    func signUp(email: String, password: String) {
        SessionManager.shared.signUpWithEmail(email: email, password: password) { [weak self] (authResult, error) in
            self?.handleFirebaseResponse(auth: authResult, err: error)
        }
    }
    
    func signIn(email: String, password: String) {
        SessionManager.shared.signInWithEmail(email: email, password: password) { [weak self](authResult, error) in
            self?.handleFirebaseResponse(auth: authResult, err: error)
        }
    }
    
    private func handleFirebaseResponse(auth: AuthDataResult?, err: Error?) {
        guard let error = err else {
            if let res = auth {
                self.delegate?.onSignUpSucess(res)
                return
            } else {
                self.delegate?.onSignUpError(Localizable.errorEmptyEntity(String(describing: auth.self)))
                return
            }
        }
        self.delegate?.onSignUpError(error.localizedDescription)
    }
    
    func restorePassword(email: String){
        Auth.auth().sendPasswordReset(withEmail: email){ error in
            if let error = error{
                self.delegate?.onResetPasswordError(error.localizedDescription)
            } else {
                self.delegate?.onResetPasswordSucess()
            }
        }
    }
    
    func signUpViaFB(){
        let loginManager = LoginManager()
        guard let vc = UIApplication.topViewController() else { return }
        loginManager.logIn(permissions: ["public_profile", "email"], from: vc) { [weak self] result, error in
            //if we ha
            if let err = error {
                self?.delegate?.onSignUpError(err.localizedDescription)
                return
            }
            guard let result = result else {
                self?.delegate?.onSignUpError(Localizable.errorFbEmptyResult())
                return
            }
            guard !result.isCancelled else {
                self?.delegate?.onSignUpError(Localizable.errorFbCanceledByUser())
                return
            }
            guard let accessToken = AccessToken.current else {
                self?.delegate?.onSignUpError(Localizable.errorFbAccessTokenNil())
                return
            }
            SessionManager.shared.signInWithFacebook(token: accessToken, completion: { (authResult, error) in
                guard let _ = error, let auth = authResult else {
                    self?.delegate?.onSignUpError(error?.localizedDescription ??
                        Localizable.errorEmptyEntity(String(describing: authResult.self)))
                    return
                }
                self?.delegate?.onSignUpSucess(auth)
            })
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
        UIApplication.topViewController()!.present(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        UIApplication.topViewController()!.dismiss(animated: true, completion: nil)
    }
    
    // MARK: GIDSignIn.sharedInstance().delegate methods
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            delegate?.onSignUpError(error.localizedDescription)
        } else {
            guard let authentication = user.authentication else { return }
            SessionManager.shared.signInWithGmail(auth: authentication) { (authResult, authError) in
                guard let _ = authError, let auth = authResult else {
                    self.delegate?.onSignUpError(authError?.localizedDescription ??
                        Localizable.errorEmptyEntity(String(describing: authResult.self)))
                    return
                }
                self.delegate?.onSignUpSucess(auth)
            }
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
    // MARK: Validate new user data
    
    func validateInputs(user: UserModel) throws {
        guard user.email.isValidEmail() else {
            throw EntranceError.invalidEmail
        }
        guard let password = user.password, password.isValidPassword() else {
            throw EntranceError.invalidPassword
        }
        guard let firstName = user.firstName, firstName.notEmpty() else {
            throw EntranceError.emptyField(fieldName: Localizable.signUpFirstName())
        }
        guard let lastName = user.lastName, lastName.notEmpty() else {
            throw EntranceError.emptyField(fieldName: Localizable.signUpSecondName())
        }
    }
    
    // MARK: Validation for sign in
    
    func validateEmailAndPassword(email: String, password: String) throws {
        guard email.isValidEmail() else { throw EntranceError.invalidEmail }
        guard password.isValidPassword() else { throw EntranceError.invalidPassword }
    }
    
}
