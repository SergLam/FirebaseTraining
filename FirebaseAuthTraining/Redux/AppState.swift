//
//  AppState.swift
//  FirebaseAuthTraining
//
//  Created by Serg Liamthev on 2/11/19.
//  Copyright © 2019 SergLam. All rights reserved.
//

import Foundation
import ReSwift

struct AppState: StateType {
    var profileState: UserProfileState
}

struct UserProfileState: StateType {
    var userProfile: UserModel?
}
