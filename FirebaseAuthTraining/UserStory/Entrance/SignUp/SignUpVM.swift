//
//  SignUpVM.swift
//  FirebaseAuthTraining
//
//  Created by Serg Liamthev on 7/26/18.
//  Copyright © 2018 SergLam. All rights reserved.
//

import Foundation
import FirebaseAuth

class SignUpVM {
    var user: UserModel?
    
    init(user: UserModel) {
        self.user = user
    }
    
    func signIn(){
        if let user = user{
            Auth.auth().createUser(withEmail: user.email, password: user.password) { (authResult, error) in
                // ...
            }
        }
    }
    
}
