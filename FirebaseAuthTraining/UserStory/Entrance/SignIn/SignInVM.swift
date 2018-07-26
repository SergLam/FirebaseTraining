//
//  EntranceVM.swift
//  FirebaseAuthTraining
//
//  Created by Serg Liamthev on 7/22/18.
//  Copyright © 2018 SergLam. All rights reserved.
//

import Foundation
import FirebaseAuth

class SignInVM {
    var user: UserModel?
    
    init(user: UserModel) {
        self.user = user
    }
    
    func signIn(){
        if let user = user{
            Auth.auth().signIn(withEmail: user.email, password: user.password) { (user, error) in
                // ...
            }
        }
    }
    
}
