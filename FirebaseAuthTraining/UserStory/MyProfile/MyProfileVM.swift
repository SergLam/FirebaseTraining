//
//  MyProfileVM.swift
//  FirebaseAuthTraining
//
//  Created by Serg Liamthev on 9/9/18.
//  Copyright © 2018 SergLam. All rights reserved.
//

import Foundation
import Moya

class MyProfileVM {
    
    let provider = MoyaProvider<FirebaseAPI>()
    
    let email = UserDefaults.standard.string(forKey: "email")
    
    func loadProfile(){
        guard let user_email = email else {
            print("Unable to get email from UserDefaults")
            return
        }
        provider.request(.getUserByEmail(email: user_email)){ result in
            switch result {
            case let .success(response):
                do {
                    print(try response.mapJSON())
                } catch {
                    print("Error during fetching user profile")
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}
