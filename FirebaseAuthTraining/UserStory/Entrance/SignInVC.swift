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
    
    var parentVC: EntranceVC?
    let viewModel = EntranceVM.sharedInstance
    
    let email = SkyFloatingLabelTextField()
    let password = SkyFloatingLabelTextField()
    let fieldTags = [1,2]
    
    let signInButton = UIButton()
    let fbButton = UIButton(type: .custom)
    let gmailButton = GIDSignInButton()
    
    let forgotPassword = UILabel()
    
    convenience init(parent: EntranceVC){
        self.init(nibName:nil, bundle:nil)
        self.parentVC = parent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = viewModel
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureUI()
    }
    
    func configureUI(){
        self.hideKeyboardOnTap()
        self.view.backgroundColor = UIColor.offBlue
        
        email.placeholder = R.string.localizable.entranceEmail()
        email.title = R.string.localizable.entranceEmail()
        email.autocapitalizationType = .none
        email.keyboardType = .emailAddress
        email.returnKeyType = .next
        email.tag = fieldTags[0]
        email.delegate = self
        email.setEntranceFieldColors()
        
        self.view.addSubview(email)
        email.snp.remakeConstraints{ (make) -> Void in
            if #available(iOS 11.0, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(10)
            } else {
                // Fallback on earlier versions
                make.top.equalTo(view.snp.topMargin).offset(10)
            }
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
        
        self.view.addSubview(password)
        password.snp.remakeConstraints{ (make) -> Void in
            make.top.equalTo(email.snp.bottom).offset(10)
            make.height.equalTo(46)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        signInButton.setTitle(R.string.localizable.signInButton(), for: .normal)
        signInButton.backgroundColor = UIColor.overcastBlue
        signInButton.round(radius: 46/2)
        signInButton.addTarget(self, action: #selector(self.signIn), for: .touchUpInside)
        
        self.view.addSubview(signInButton)
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
        fbButton.addTarget(self, action: #selector(self.facebookLogin), for: .touchUpInside)
        let textWidth = "Continue with Facebook".widthOfString(font: fbButton.titleLabel!.font)
        
        self.view.addSubview(fbButton)
        fbButton.snp.remakeConstraints{ (make) -> Void in
            make.top.equalTo(signInButton.snp.bottom).offset(25)
            make.height.equalTo(46)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        self.view.addSubview(gmailButton)
        gmailButton.snp.remakeConstraints{ (make) -> Void in
            make.top.equalTo(fbButton.snp.bottom).offset(20)
            make.centerX.equalTo(self.view.center.x)
        }
        
        forgotPassword.text = R.string.localizable.signInForgotPassword()
        forgotPassword.textColor = UIColor.overcastBlue
        forgotPassword.font = UIFont.systemFont(ofSize: 14)
        forgotPassword.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.restorePassword))
        forgotPassword.addGestureRecognizer(tap)
        
        self.view.addSubview(forgotPassword)
        forgotPassword.snp.remakeConstraints{ (make) -> Void in
            make.bottom.equalTo(self.view).offset(-25)
            make.height.equalTo(27)
            make.centerX.equalTo(signInButton.snp.centerX)
        }
    }
    
    func validateInputs() -> (Bool, String) {
        let isEmail = viewModel.validateEmail(email: self.email.text)
        return isEmail ? (true, "OK") : (false, "Invalid email")
    }
    
    @objc func signIn(){
        let validation = validateInputs()
        if(validation.0) {
            viewModel.signIn(email: email.text!, password: password.text!){ completion in
                if(completion){
                    self.parentVC?.showMainVC()
                }
            }
        } else{
            self.showError(error: validation.1)
        }
    }
    
    // MARK: Facebook login
    @objc func facebookLogin(){
        viewModel.signUpViaFB(){ completion in
            if(completion){
                self.parentVC?.showMainVC()
            }
        }
    }
    
    @objc func restorePassword(){
        let alert = SCLAlertView()
        let textField = alert.addTextField("Email")
        textField.autocapitalizationType = .none
        alert.addButton("Send", backgroundColor: UIColor.offBlue, textColor:  UIColor.black, showTimeout: nil){
            if let text = textField.text, !text.isEmpty, self.viewModel.validateEmail(email: text){
                self.viewModel.restorePassword(email: text)
            } else {
                SCLAlertView().showError("Restore password", subTitle: "Invalid email", closeButtonTitle: "OK")
            }
        }
        alert.showInfo("Restore password", subTitle: "Enter your email. We will send instructions to reset password", closeButtonTitle: "Cancel") // Info
    }
    
    // MARK: TextField delegate methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let tag = textField.tag
        switch tag {
        case fieldTags[0]:
            password.becomeFirstResponder()
            return true
        case fieldTags[1]:
            textField.resignFirstResponder()
            return true
        default:
            return true
        }
    }
    
    
    
}

