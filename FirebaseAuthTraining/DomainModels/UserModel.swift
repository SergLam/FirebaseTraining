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
    
    init(firstName: String, lastName: String, email: String, password: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
    }
    
    enum CodingKeys: String, CodingKey {
        case uid = "uid"
        case createdAt = "createdAt"
        case displayName = "displayName"
        case firstName = "firstName"
        case lastName = "lastName"
        case lastSignInTime = "lastSignInTime"
        case email = "email"
        case password = "password"
        case photoURL = "photoURL"
        case location = "location"
    }
    
    static func fromJSON(_ data: Any) -> UserModel? {
        let jsonDecoder = JSONDecoder()
        var model: UserModel?
        do{
            model = try jsonDecoder.decode(UserModel.self, from: data as! Data)
        } catch {
            debugPrint(error)
        }
        return model
    }
    
}

struct Location: Codable {
    var latitude: Double = 0
    var longitude: Double = 0
    
    enum CodingKeys: String, CodingKey {
        case latitude = "latitude"
        case longitude = "longitude"
    }

}

