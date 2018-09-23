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
    
    var user: UserModel? = nil
    
    let email = UserDefaults.standard.string(forKey: "email")
    
    func loadUser(completion: @escaping(Bool)->()){
        guard let user_email = email else {
            print("Unable to get email from UserDefaults")
            return
        }
        print("Email: \(user_email)")
        print("Load User")
        provider.request(.getUserByEmail(email: user_email)){ result in
            switch result {
            case let .success(response):
                do {
                    print(try response.mapJSON())
                    self.user = UserModel.fromJSON(response.data)
                    completion(true)
                } catch {
                    print("Error during fetching user profile")
                }
            case let .failure(error):
                do {
                    print(try error.response?.mapJSON() ?? "")
                    completion(false)
                } catch {
                    print("Error during fetching error user profile")
                }
            }
        }
    }
    
    func updateUser(user: UserModel, completion: @escaping (Bool) -> ()){
        print("Update user")
        provider.request(.updateUser(user: user)){ result in
            switch result {
            case let .success(response):
                do {
                    print(try response.mapJSON())
                    completion(true)
                } catch {
                    print("Error during updating user")
                }
            case let .failure(error):
                print(error)
                do {
                    if let body = try error.response?.mapJSON(){
                        print(body)
                        completion(false)
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
    
}
