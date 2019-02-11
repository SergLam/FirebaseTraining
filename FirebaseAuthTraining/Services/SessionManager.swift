//
//  SessionManager.swift
//  FirebaseAuthTraining
//
//  Created by Serg Liamthev on 2/9/19.
//  Copyright © 2019 SergLam. All rights reserved.
//

import Foundation
import KeychainSwift
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn
import FirebaseAuth

typealias firebaseAuthResult = (AuthDataResult?, Error?) -> ()

class SessionManager {
    
    static let shared = SessionManager()
    
    func canLogin() -> Bool {
        let keychain = KeychainSwift()
        if let _ = keychain.get(KeychainKeys.email) {
            if let _ = keychain.get(KeychainKeys.password) {
                return true
            }
        } else if let _ = keychain.get(KeychainKeys.facebookToken) {
            return true
        }
        return false
    }
    
    private func saveUserCredentials(email: String? = nil, password: String? = nil,
                                     fbToken: String? = nil, fbTokenExpDate: String? = nil,
                                     googleIDToken: String? = nil, googleRefreshToken: String? = nil) {
        let keychain = KeychainSwift()
        if let mail = email { keychain.set(mail, forKey: KeychainKeys.email) }
        if let pass = password { keychain.set(pass, forKey: KeychainKeys.password) }
        
        if let fbToken = fbToken { keychain.set(fbToken, forKey: KeychainKeys.facebookToken) }
        if let fbTokenExpDate = fbTokenExpDate { keychain.set(fbTokenExpDate, forKey: KeychainKeys.fbTokenExpirationDate) }
        
        if let gIDToken = googleIDToken { keychain.set(gIDToken, forKey: KeychainKeys.gIdToken) }
        if let gRefreshToken = googleRefreshToken { keychain.set(gRefreshToken, forKey: KeychainKeys.gRefreshToken) }
    }
    
    func deleteUserCredentials() {
        let keychain = KeychainSwift()
        keychain.delete(KeychainKeys.email)
        keychain.delete(KeychainKeys.password)
        keychain.delete(KeychainKeys.facebookToken)
        keychain.delete(KeychainKeys.fbTokenExpirationDate)
        keychain.delete(KeychainKeys.gIdToken)
        keychain.delete(KeychainKeys.gRefreshToken)
    }
    
    // MARK: Meth
    
    func signInWithFacebook(token: FBSDKAccessToken, completion: @escaping firebaseAuthResult) {
        let credential = FacebookAuthProvider.credential(withAccessToken: token.tokenString)
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let _ = authResult {
                let dateString = ISO8601DateFormatter().string(from: token.expirationDate)
                self.saveUserCredentials(fbToken: token.tokenString, fbTokenExpDate: dateString)
            }
            completion(authResult, error)
        }
    }
    
    // MARK: only for UI login. For background login - create cloud function and send idToken there
    func signInWithGmail(auth: GIDAuthentication, completion: @escaping firebaseAuthResult) {
        let credential = GoogleAuthProvider.credential(withIDToken: auth.idToken,
                                                       accessToken: auth.accessToken)
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let _ = authResult {
                self.saveUserCredentials(googleIDToken: auth.idToken,
                                         googleRefreshToken: auth.refreshToken)
            }
            completion(authResult, error)
        }
    }
    
    // MARK: Could be used for both cases: background login, UI login
    
    func signInWithEmail(email: String, password: String, completion: @escaping firebaseAuthResult) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let _ = authResult {
                self.saveUserCredentials(email: email, password: password)
            }
            completion(authResult, error)
        }
    }
    
    func signUpWithEmail(email: String, password: String, completion: @escaping firebaseAuthResult) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let _ = authResult {
                self.saveUserCredentials(email: email, password: password)
            }
            completion(authResult, error)
        }
    }
    
}
