//
//  SignInView.swift
//  FirebaseAuthTraining
//
//  Created by Serg Liamthev on 2/9/19.
//  Copyright © 2019 SergLam. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SnapKit
import GoogleSignIn
import Closures

protocol SignInViewDelegate: AnyObject {
    func didTapSignInButton(email: String, password: String)
    func didTapRestorePasswordButton()
    func didTapFBLoginButton()
}

final class SignInView: UIView {
    
    weak var delegate: SignInViewDelegate?
    
    private let email = SkyFloatingLabelTextField()
    private let password = SkyFloatingLabelTextField()
    
    var userInput: [String] = ["",""]
    private let fieldTags = [1,2]
    
    private let signInButton = UIButton()
    private let fbButton = UIButton(type: .custom)
    private let gmailButton = GIDSignInButton()
    
    private let forgotPassword = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        backgroundColor = UIColor.offBlue
        
        email.placeholder = R.string.localizable.entranceEmail()
        email.title = R.string.localizable.entranceEmail()
        email.autocapitalizationType = .none
        email.keyboardType = .emailAddress
        email.returnKeyType = .next
        email.tag = fieldTags[0]
        email.delegate = self
        email.setEntranceFieldColors()
        
        addSubview(email)
        email.snp.remakeConstraints{ (make) -> Void in
            make.top.equalTo(safeAreaLayoutGuide.snp.topMargin).offset(10)
            make.height.equalTo(46)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        password.placeholder = R.string.localizable.entrancePassword()
        password.title = R.string.localizable.entrancePassword()
        password.isSecureTextEntry = true
        password.returnKeyType = .done
        password.tag = fieldTags[1]
        password.delegate = self
        password.setEntranceFieldColors()
        
        addSubview(password)
        password.snp.remakeConstraints{ (make) -> Void in
            make.top.equalTo(email.snp.bottom).offset(10)
            make.height.equalTo(46)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        signInButton.setTitle(R.string.localizable.signInButton(), for: .normal)
        signInButton.backgroundColor = UIColor.overcastBlue
        signInButton.round(radius: 46/2)
        signInButton.onTap { [unowned self] in
            self.delegate?.didTapSignInButton(email: self.userInput[0], password: self.userInput[1])
        }
        
        addSubview(signInButton)
        signInButton.snp.remakeConstraints{ (make) -> Void in
            make.top.equalTo(password.snp.bottom).offset(25)
            make.height.equalTo(46)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        // Add a custom login button to your app
        fbButton.backgroundColor = UIColor.facebookLogo
        fbButton.setTitle("Continue with Facebook", for: .normal)
        fbButton.setTitleColor(.white, for: .normal)
        fbButton.round(radius: 46/2)
        // Handle clicks on the button
        fbButton.onTap { [unowned self] in
            self.delegate?.didTapFBLoginButton()
        }
        
        addSubview(fbButton)
        fbButton.snp.remakeConstraints{ (make) -> Void in
            make.top.equalTo(signInButton.snp.bottom).offset(25)
            make.height.equalTo(46)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        addSubview(gmailButton)
        gmailButton.snp.remakeConstraints{ (make) -> Void in
            make.top.equalTo(fbButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        forgotPassword.text = R.string.localizable.signInForgotPassword()
        forgotPassword.textColor = UIColor.overcastBlue
        forgotPassword.font = UIFont.systemFont(ofSize: 14)
        forgotPassword.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.restorePassword))
        forgotPassword.addGestureRecognizer(tap)
        
        addSubview(forgotPassword)
        forgotPassword.snp.remakeConstraints{ (make) -> Void in
            make.bottom.equalToSuperview().offset(-25)
            make.height.equalTo(27)
            make.centerX.equalTo(signInButton.snp.centerX)
        }
    }
    
    @objc func restorePassword() {
        self.delegate?.didTapRestorePasswordButton()
    }
    
}

extension SignInView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let tag = textField.tag
        let text = textField.text ?? ""
        switch tag {
        case fieldTags[0]:
            userInput[0] = text + string
        case fieldTags[1]:
            userInput[1] = text + string
        default:
            break
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let tag = textField.tag
        switch tag {
        case fieldTags[0]:
            password.becomeFirstResponder()
        case fieldTags[1]:
            textField.resignFirstResponder()
        default:
            break
        }
        return true
    }
    
}
