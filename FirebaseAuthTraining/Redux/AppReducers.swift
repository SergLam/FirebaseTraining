//
//  AppReducers.swift
//  FirebaseAuthTraining
//
//  Created by Serg Liamthev on 2/11/19.
//  Copyright © 2019 SergLam. All rights reserved.
//

import Foundation
import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState(profileState: profileReducer(action: action, state: state?.profileState))
}

func profileReducer(action: Action, state: UserProfileState?) -> UserProfileState {
    var profileState = state ?? UserProfileState()
    
    switch action {
    case _ as SignOutAction:
        profileState.userProfile = nil
        SessionManager.shared.deleteUserCredentials()
    case let signIn as SignInAction:
        profileState.userProfile = signIn.profile
    default:
        break
    }
    
    return profileState
}
