//
//  AppRouter.swift
//  FirebaseAuthTraining
//
//  Created by Serg Liamthev on 2/9/19.
//  Copyright © 2019 SergLam. All rights reserved.
//

import UIKit

final class AppRouter {
    
    enum AppState {
        case none
        case login
        case profile
    }
    
    static var state: AppState = .none
    static let shaded = AppRouter()
    
    static func showLogin() {
        guard state != .login else {return}
        state = .login
        let entranceVC = UINavigationController(rootViewController: EntranceVC())
        changeRootVC(to: entranceVC)
    }
    
    static func showProfile() {
        guard state != .profile else { return }
        state = .profile
        let tabBarVC = MainVC()
        changeRootVC(to: tabBarVC)
    }
    
    private static func changeRootVC(to vc: UIViewController) {
        let window = UIApplication.shared.keyWindow
        window?.rootViewController = vc
    }
}
