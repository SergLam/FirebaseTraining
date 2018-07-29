//
//  User.swift
//  FirebaseAuthTraining
//
//  Created by Serg Liamthev on 7/26/18.
//  Copyright © 2018 SergLam. All rights reserved.
//

import Foundation
import SwiftyJSON

final class UserModel: JSONAbleType {
    
    var firstName: String = ""
    var secondName:String = ""
    var email: String = ""
    var password: String = ""
    
    static func fromJSON(_ data: Any) -> UserModel {
        let model = UserModel()
        let _ = JSON(data)
        
        return model
    }
}
