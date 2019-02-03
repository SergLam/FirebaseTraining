//
//  SignUpVC.swift
//  FirebaseAuthTraining
//
//  Created by Serg Liamthev on 7/22/18.
//  Copyright © 2018 SergLam. All rights reserved.
//

import UIKit
import Rswift
import SnapKit
import SkyFloatingLabelTextField
import SafariServices
import GoogleSignIn

class SignUpVC: UIViewController, UITextFieldDelegate, ExternalURLOpenable, GIDSignInUIDelegate {
    
    var parentVC: EntranceVC?
    
    let contentView = SignUpView()
    let viewModel = EntranceVM.sharedInstance
    
    
    convenience init(parent: EntranceVC){
        self.init(nibName:nil, bundle:nil)
        self.parentVC = parent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = viewModel
        self.hideKeyboardOnTap()
    }
    
}

extension SignUpVC: SignUpViewDelegate {
    func didTapLinkInLabel(_ urlString: String) {
        openURL(urlString)
    }
    
    func didTapSignUpButton() {
        let input = contentView.userInput
        let user = UserModel(firstName: input[0], lastName: input[1], email: input[2], password: input[3])
        let validation = viewModel.validateInputs(user: user)
        if(validation.0){
            debugPrint("Sign Up")
            viewModel.signUp(email: input[2], password: input[3]){ completion in
                if(completion){
                    self.parentVC?.showMainVC()
                }
            }
        } else {
            self.showError(error: validation.1)
        }
    }
    
    func didTapFacebookLoginButton() {
        viewModel.signUpViaFB(){ completion in
            self.parentVC?.showMainVC()
        }
    }
}
