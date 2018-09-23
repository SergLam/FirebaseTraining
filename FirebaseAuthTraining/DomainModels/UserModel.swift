//
//  User.swift
//  FirebaseAuthTraining
//
//  Created by Serg Liamthev on 7/26/18.
//  Copyright © 2018 SergLam. All rights reserved.
//

import Foundation

public class UserModel: Codable {
    
    var uid: String = ""
    var createdAt: String = ""
    var displayName: String?
    var firstName: String?
    var lastName:String?
    var lastSignInTime: String = ""
    var email: String = ""
    // Password - only for validation convinience purposes!
    var password: String?
    var photoURL: String?
    var location: Location?
    
    static func fromJSON(_ data: Any) -> UserModel {
        let jsonDecoder = JSONDecoder()
        var model = UserModel()
        do{
           model = try jsonDecoder.decode(UserModel.self, from: data as! Data)
        } catch {
           print(error)
        }
        return model
    }
}

public struct Location: Codable {
    var latitude: Double = 0
    var longitude: Double = 0
    
    public init(lat: Double, lon: Double) {
        self.latitude = lat
        self.longitude = lon
    }
}

