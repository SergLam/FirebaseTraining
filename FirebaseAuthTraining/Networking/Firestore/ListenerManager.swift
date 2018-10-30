//
//  UserObserver.swift
//  FirebaseAuthTraining
//
//  Created by Serg Liamthev on 8/3/18.
//  Copyright © 2018 SergLam. All rights reserved.
//

import UIKit
import Firebase

class ListenerManager {
    
    static let sharedInstance = ListenerManager()
    
    var listeners: [String: ListenerRegistration] = [:]
    
    func observeUserProfile(uid: String){
        if(Auth.auth().currentUser != nil) {
            let userRef = AppDelegate.sharedFirestore.collection("users").document(uid)
            let listener = userRef.addSnapshotListener { documentSnapshot, error in
                    guard let snapshot = documentSnapshot else {
                        print("Error fetching document: \(error!)")
                        return
                    }
                    let source = snapshot.metadata.isFromCache
                    
                    
                    print("\(source) User observing: \(String(describing: snapshot.data()))")
            }
            listeners["userProfile"] = listener
        }
    }
    
    func removeUserProfileListerer() {
        if let index = listeners.index(forKey: "userProfile") {
            listeners["userProfile"]?.remove()
            listeners.remove(at: index)
        }
    }
    
    
    
    
}

    

    

