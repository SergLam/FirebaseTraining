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

class SignInVC: UIViewController, UITextFieldDelegate{
    
    let viewModel = EntranceVM()
    
    let email = SkyFloatingLabelTextField()
    let password = SkyFloatingLabelTextField()
    let fieldTags = [1,2]
    
    let signInButton = UIButton()
    let forgotPassword = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        email.returnKeyType = .next
        email.tag = fieldTags[0]
        email.delegate = self
        email.setEntranceFieldColors()
        
        self.view.addSubview(email)
        email.snp.remakeConstraints{ (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(10)
            make.height.equalTo(46)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        password.placeholder = R.string.localizable.entrancePassword()
        password.title = R.string.localizable.entrancePassword()
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
        
        self.view.addSubview(signInButton)
        signInButton.snp.remakeConstraints{ (make) -> Void in
            make.top.equalTo(password.snp.bottom).offset(25)
            make.height.equalTo(46)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        forgotPassword.text = R.string.localizable.signInForgotPassword()
        forgotPassword.textColor = UIColor.overcastBlue
        forgotPassword.font = UIFont.systemFont(ofSize: 14)
        forgotPassword.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.restorePassword))
        forgotPassword.addGestureRecognizer(tap)
        
        self.view.addSubview(forgotPassword)
        forgotPassword.snp.remakeConstraints{ (make) -> Void in
            make.top.equalTo(signInButton.snp.bottom).offset(25)
            make.height.equalTo(27)
            make.centerX.equalTo(signInButton.snp.centerX)
        }
    }
    
    @objc func restorePassword(){
        let alert = SCLAlertView()
        let textField = alert.addTextField("Email")
        let button = alert.addButton("Send", backgroundColor: UIColor.offBlue, textColor:  UIColor.black, showTimeout: nil){
            if let text = textField.text, !text.isEmpty, self.viewModel.validateEmail(email: text){
                SCLAlertView().showSuccess("Restore password", subTitle: "An email has been sent", closeButtonTitle: "OK")
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

