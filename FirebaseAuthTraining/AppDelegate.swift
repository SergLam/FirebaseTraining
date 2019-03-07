//
//  AppDelegate.swift
//  FirebaseAuthTraining
//
//  Created by Serg Liamthev on 7/22/18.
//  Copyright © 2018 SergLam. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn
import GoogleMaps
import GooglePlaces
import ReSwift

let store = Store<AppState>(reducer: appReducer, state: nil, middleware: [])

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    static let sharedFirestore = Firestore.firestore()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        window?.rootViewController = EntranceVC()
//        window?.rootViewController = MainVC()
        
        VendorService.setupServices(application, launchOptions)
        return true
    }
    
    
}

