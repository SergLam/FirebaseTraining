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

class SignInVC: UIViewController, UITextFieldDelegate{
    
    let email = SkyFloatingLabelTextField()
    let password = SkyFloatingLabelTextField()
    let fieldTags = [1,2]
    
    let signInButton = UIButton()
    let forgotPassword = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureUI(){
        self.hideKeyboardOnTap()
        self.view.backgroundColor = UIColor.lightKhaki
        
        email.placeholder = R.string.localizable.entranceEmail()
        email.title = R.string.localizable.entranceEmail()
        email.returnKeyType = .next
        email.tag = fieldTags[0]
        email.delegate = self
        email.setEntranceFieldColors()
        
        self.view.addSubview(email)
        email.snp.makeConstraints{ (make) -> Void in
            make.top.equalToSuperview().offset(10)
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
        password.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(email.snp.bottom).offset(10)
            make.height.equalTo(46)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        signInButton.setTitle(R.string.localizable.signInButton(), for: .normal)
        signInButton.backgroundColor = UIColor.overcastBlue
        signInButton.round(radius: 46/2)
        
        self.view.addSubview(signInButton)
        signInButton.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(password.snp.bottom).offset(25)
            make.height.equalTo(46)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        forgotPassword.text = R.string.localizable.signInForgotPassword()
        forgotPassword.textColor = UIColor.offBlue
        
        self.view.addSubview(forgotPassword)
        forgotPassword.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(signInButton.snp.bottom).offset(25)
            make.height.equalTo(27)
            make.centerX.equalTo(signInButton.snp.centerX)
        }
        

       
        
    }
    
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

