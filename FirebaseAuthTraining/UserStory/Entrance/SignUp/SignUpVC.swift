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
        configureUI()
    }
    
    private func configureUI() {
        view.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
}

extension SignUpVC: SignUpViewDelegate {
    func didTapLinkInLabel(_ urlString: String) {
        openURL(urlString)
    }
    
    func didTapSignUpButton() {
        let input = contentView.userInput
        let user = UserModel(firstName: input[0], lastName: input[1], email: input[2], password: input[3])
        do {
            try viewModel.validateInputs(user: user)
        } catch {
            guard let error = error as? EntranceError else { return }
            self.showError(error: error.description)
        }
        viewModel.signUp(email: input[2], password: input[3]){ completion in
            if(completion){
                self.parentVC?.showMainVC()
            }
        }
    }
    
    func didTapFacebookLoginButton() {
        viewModel.signUpViaFB(){ completion in
            if(completion){
                self.parentVC?.showMainVC()
            }
        }
    }
}
