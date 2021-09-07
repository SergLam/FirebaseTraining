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
    case updateUser(user: UserModel)
}

// 2:
extension FirebaseAPI: TargetType {
    
    public var baseURL: URL {
        switch self {
//        case .updateUser:
//            return URL.init(string: "https://us-central1-fir-auth-training.cloudfunctions.net")!
        default:
            return URL.init(string: "https://fir-auth-training.firebaseio.com")!
        }
    }

    public var path: String {
        switch self {
        case .signUp:
            return "/sign_up"
        case .signIn:
            return "/sign_in"
        case .getUserByEmail:
            return "/get_user_by_email"
        case .updateUser:
            return "/update_user"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .signUp:
            return .post
        case .signIn:
            return .post
        case .getUserByEmail:
            return .post
        case .updateUser:
            return .post
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
        case let .updateUser(user):
            return .requestJSONEncodable(user)
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
