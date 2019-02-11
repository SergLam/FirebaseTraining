//
//  ViewController.swift
//  FirebaseAuthTraining
//
//  Created by Serg Liamthev on 7/22/18.
//  Copyright © 2018 SergLam. All rights reserved.
//

import UIKit
import SnapKit
import SkyFloatingLabelTextField
import SCLAlertView
import GoogleSignIn

class SignInVC: UIViewController, UITextFieldDelegate, GIDSignInUIDelegate{
    
    private var parentVC: EntranceVC?
    private let viewModel = EntranceVM.sharedInstance
    
    private let contentView = SignInView()
    
    convenience init(parent: EntranceVC){
        self.init(nibName:nil, bundle:nil)
        self.parentVC = parent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.delegate = self
        viewModel.delegate = parentVC
        GIDSignIn.sharedInstance().uiDelegate = viewModel
        configureUI()
    }
    
    private func configureUI() {
        self.hideKeyboardOnTap()
        view.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
}

extension SignInVC: SignInViewDelegate {
    
    func didTapSignInButton(email: String, password: String) {
        do {
            try viewModel.validateEmailAndPassword(email: email, password: password)
        } catch {
            guard let error = error as? EntranceError else { return }
            SCLAlertView().showError(R.string.localizable.errorAlertTitle(), subTitle: error.description)
        }
        viewModel.signIn(email: email, password: password)
    }
    
    func didTapRestorePasswordButton() {
        let alert = SCLAlertView()
        let textField = alert.addTextField("Email")
        textField.autocapitalizationType = .none
        alert.addButton("Send", backgroundColor: UIColor.offBlue, textColor:  UIColor.black, showTimeout: nil){
            if let text = textField.text, !text.isEmpty, text.isValidEmail() {
                self.viewModel.restorePassword(email: text)
            } else {
                SCLAlertView().showError("Restore password", subTitle: "Invalid email", closeButtonTitle: "OK")
            }
        }
        alert.showInfo("Restore password", subTitle: "Enter your email. We will send instructions to reset password", closeButtonTitle: "Cancel") // Info
    }
    
    func didTapFBLoginButton() {
        viewModel.signUpViaFB()
    }
    
}

