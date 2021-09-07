//
//  AppConstants.swift
//  FirebaseAuthTraining
//
//  Created by Serg Liamthev on 2/10/19.
//  Copyright © 2019 SergLam. All rights reserved.
//

import Foundation

typealias Localizable = R.string.localizable

struct KeychainKeys {
    static let email = "firebase-training-email"
    static let password = "firebase-training-password"
    
    static let facebookToken = "firebase-training-facebook-token"
    static let fbTokenExpirationDate = "firebase-training-facebook-token-expiration"
    
    static let gIdToken = "firebase-training-google-id-token"
    static let gRefreshToken = "firebase-training-google-refresh-token"
}

struct AppConstants {
    static let googleApiKey = "AIzaSyCA1t8DtFDxTAxe8akmJi_sBiG6u3V_LLw"
}
