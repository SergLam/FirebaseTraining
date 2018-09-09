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
public enum FirebaseAPI {
    
    // MARK: - User
    case signUp(UserModel)
    case signIn(email: String, password: String)
    case getUserByEmail(email: String)
}

// 2:
extension FirebaseAPI: TargetType {
    public var baseURL: URL {
        switch self {
        case .getUserByEmail:
            return URL.init(string: "https://us-central1-fir-auth-training.cloudfunctions.net")!
        default:
            return URL.init(string: "https://fir-auth-training.firebaseio.com")!
        }
        return URL.init(string: "https://fir-auth-training.firebaseio.com")!
    }

    public var path: String {
        switch self {
        case .signUp:
            return "/users"
        case .signIn:
            return "/users"
        case .getUserByEmail:
            return "/get_user_by_email"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .signUp:
            return .post
        case .getUserByEmail:
            return .post
        default:
            return .get
        }
    }

    public var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    public var sampleData: Data {
        return Data()
    }

    public var task: Task {
        switch self {
        case let .getUserByEmail(email):
            return .requestParameters(parameters: ["email": email], encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
        
    }

    public var headers: [String : String]? {
        switch self{
        default:
            return ["Content-Type": "application/json"]
        }
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }

}
