//
//  NetworkService.swift
//  FirebaseAuthTraining
//
//  Created by Serg Liamthev on 7/25/18.
//  Copyright © 2018 SergLam. All rights reserved.
//

import Foundation
import Moya

// 1:
enum FirebaseAPI {
    
    // MARK: - User
    case signUp(UserModel)
    case signIn(email: String, password: String)
}

// 2:
extension FirebaseAPI: TargetType {
    var baseURL: URL {
        return URL.init(string: "https://fir-auth-training.firebaseio.com")!
    }

    var path: String {
        switch self {
        case .signUp:
            return "/users"
        case .signIn:
            return "/users"
        }
    }

    var method: Moya.Method {
        switch self {
        case .signUp:
            return .post
        default:
            return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        return .requestPlain
    }

    var headers: [String : String]? {
        switch self{
        case .signUp:
            return ["Content-Type": "application/json"]
        default:
            return ["Content-Type": "application/json"]
        }
    }

}
