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

final class SignUpVC: UIViewController {
    
    private var parentVC: EntranceVC?
    
    private let contentView = SignUpView()
    private let viewModel = EntranceVM.sharedInstance
    
    convenience init(parent: EntranceVC){
        self.init(nibName:nil, bundle:nil)
        self.parentVC = parent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.delegate = self
        viewModel.delegate = parentVC
        GIDSignIn.sharedInstance().delegate = viewModel
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

// MARK: - GIDSignInDelegate
extension SignUpVC: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
    }
    
}

// MARK: - UITextFieldDelegate
extension SignUpVC: UITextFieldDelegate {
    
}

// MARK: - SFSafariViewControllerDelegate
extension SignUpVC: SignUpViewDelegate, SFSafariViewControllerDelegate {
    func didTapLinkInLabel(_ urlString: String) {
        openURL(urlString)
    }
    
    func openURL(_ urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        let safariVC = SFSafariViewController(url: url)
        parentVC?.present(safariVC, animated: true, completion: nil)
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func didTapSignUpButton() {
        let input = contentView.userInput
        let user = UserModel(firstName: input[0], lastName: input[1], email: input[2], password: input[3])
        do {
            try viewModel.validateInputs(user: user)
        } catch {
            guard let error = error as? EntranceError else { return }
            self.showError(error: error.description)
            return
        }
        viewModel.signUp(email: input[2], password: input[3])
    }
    
    func didTapFacebookLoginButton() {
        viewModel.signUpViaFB()
    }
}
