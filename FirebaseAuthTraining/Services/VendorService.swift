//
//  VendorService.swift
//  FirebaseAuthTraining
//
//  Created by Serg Liamthev on 3/7/19.
//  Copyright © 2019 SergLam. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn
import GoogleMaps
import GooglePlaces
import ReSwift

class VendorService {
    
    static func setupServices(_ application: UIApplication, _ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        // Configure Firebase
        FirebaseApp.configure()
        let settings = FirestoreSettings()
        settings.isPersistenceEnabled = true
        // Enable offline data persistence
        let db = Firestore.firestore()
        db.settings = settings
        
        // Configure Google sign in
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = EntranceVM.sharedInstance
        
        // Configure GoogleMaps + GooglePlaces
        GMSServices.provideAPIKey(AppConstants.googleApiKey)
        GMSPlacesClient.provideAPIKey(AppConstants.googleApiKey)
        
        // Configure facebook login
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    // MARK: Google Sign in methods
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
        -> Bool {
            return GIDSignIn.sharedInstance().handle(url,
                                                     sourceApplication:options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: [:])
    }
    
    
}
