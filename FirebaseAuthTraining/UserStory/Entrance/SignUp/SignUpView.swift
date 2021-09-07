//
//  SignUpView.swift
//  FirebaseAuthTraining
//
//  Created by Serg Liamthev on 2/3/19.
//  Copyright © 2019 SergLam. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import GoogleSignIn
import Closures

protocol SignUpViewDelegate: AnyObject {
    func didTapLinkInLabel(_ urlString: String)
    func didTapSignUpButton()
    func didTapFacebookLoginButton()
}

final class SignUpView: UIView {
    
    weak var delegate: SignUpViewDelegate?
    
    private let firstName = SkyFloatingLabelTextField()
    private let lastName = SkyFloatingLabelTextField()
    private let email = SkyFloatingLabelTextField()
    private let password = SkyFloatingLabelTextField()
    
    var userInput: [String] = ["","","",""]
    private let fieldTags = [1,2,3,4]
    
    private let signUpButton = UIButton()
    private let fbButton = UIButton(type: .custom)
    private let gmailButton = GIDSignInButton()
    
    private let termsAndConditions = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        
        backgroundColor = UIColor.offBlue
        
        firstName.placeholder = R.string.localizable.signUpFirstName()
        firstName.title = R.string.localizable.signUpFirstName()
        firstName.returnKeyType = .next
        firstName.tag = fieldTags[0]
        firstName.delegate = self
        firstName.setEntranceFieldColors()
        
        addSubview(firstName)
        firstName.snp.remakeConstraints{ (make) -> Void in
            make.top.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(46)
            make.left.right.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10))
        }
        
        lastName.placeholder = R.string.localizable.signUpSecondName()
        lastName.title = R.string.localizable.signUpSecondName()
        lastName.returnKeyType = .next
        lastName.tag = fieldTags[1]
        lastName.delegate = self
        lastName.setEntranceFieldColors()
        
        addSubview(lastName)
        lastName.snp.remakeConstraints{ (make) -> Void in
            make.top.equalTo(firstName.snp.bottom)
            make.height.equalTo(46)
            make.left.right.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10))
        }
        
        email.placeholder = R.string.localizable.entranceEmail()
        email.title = R.string.localizable.entranceEmail()
        email.autocapitalizationType = .none
        email.keyboardType = .emailAddress
        email.returnKeyType = .next
        email.tag = fieldTags[2]
        email.delegate = self
        email.setEntranceFieldColors()
        
        addSubview(email)
        email.snp.remakeConstraints{ (make) -> Void in
            make.top.equalTo(lastName.snp.bottom)
            make.height.equalTo(46)
            make.left.right.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10))
        }
        
        password.placeholder = R.string.localizable.entrancePassword()
        password.title = R.string.localizable.entrancePassword()
        password.isSecureTextEntry = true
        password.returnKeyType = .done
        password.tag = fieldTags[3]
        password.delegate = self
        password.setEntranceFieldColors()
        
        addSubview(password)
        password.snp.remakeConstraints{ (make) -> Void in
            make.top.equalTo(email.snp.bottom)
            make.height.equalTo(46)
            make.left.right.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10))
        }
        
        signUpButton.setTitle(R.string.localizable.signUpButton(), for: .normal)
        signUpButton.backgroundColor = UIColor.overcastBlue
        signUpButton.round(radius: 46/2)
        signUpButton.onTap { [unowned self] in
            self.delegate?.didTapSignUpButton()
        }
        
        addSubview(signUpButton)
        signUpButton.snp.remakeConstraints{ (make) -> Void in
            make.top.equalTo(password.snp.bottom).offset(25)
            make.height.equalTo(46)
            make.left.right.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        }
        
        // Add a custom login button to your app
        fbButton.backgroundColor = UIColor.facebookLogo
        fbButton.setTitle("Continue with Facebook", for: .normal)
        fbButton.setTitleColor(.white, for: .normal)
        fbButton.round(radius: 46/2)
        fbButton.onTap { [unowned self] in
            self.delegate?.didTapFacebookLoginButton()
        }
        
        addSubview(fbButton)
        fbButton.snp.remakeConstraints{ (make) -> Void in
            make.top.equalTo(signUpButton.snp.bottom).offset(25)
            make.height.equalTo(46)
            make.left.right.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        }
        
        addSubview(gmailButton)
        gmailButton.snp.remakeConstraints{ (make) -> Void in
            make.top.equalTo(fbButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        termsAndConditions.numberOfLines = 2
        termsAndConditions.text = R.string.localizable.signUpRules()
        termsAndConditions.textAlignment = .center
        termsAndConditions.textColor = UIColor.overcastBlue
        termsAndConditions.adjustsFontSizeToFitWidth = true
        termsAndConditions.minimumScaleFactor = 0.1
        termsAndConditions.font = UIFont.systemFont(ofSize: 25)
        termsAndConditions.highLightLinksInText(links: [R.string.localizable.signUpTerms(), R.string.localizable.signUpPrivacy()])
        termsAndConditions.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapTermsAndConditionsLabel))
        termsAndConditions.addGestureRecognizer(tap)
        
        addSubview(termsAndConditions)
        termsAndConditions.snp.remakeConstraints{ (make) -> Void in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(46)
            make.left.right.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 25, right: 10))
        }
    }
    
    @objc func tapTermsAndConditionsLabel(){
        let text = R.string.localizable.signUpRules()
        let termsRange = (text as NSString).range(of: R.string.localizable.signUpTerms())
        let privacyRange = (text as NSString).range(of: R.string.localizable.signUpPrivacy())
        if let tap = termsAndConditions.gestureRecognizers?[0] as? UITapGestureRecognizer {
        if tap.didTapAttributedTextInLabel(label: termsAndConditions, inRange: termsRange) {
            self.delegate?.didTapLinkInLabel("https://www.google.com/")
        } else if tap.didTapAttributedTextInLabel(label: termsAndConditions, inRange: privacyRange) {
            self.delegate?.didTapLinkInLabel("https://github.com/")
        }
        }
    }
}

extension SignUpView: UITextFieldDelegate {
    // MARK: TextFields delegate methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let tag = textField.tag
        switch tag {
        case fieldTags[0]:
            lastName.becomeFirstResponder()
            return true
        case fieldTags[1]:
            email.becomeFirstResponder()
            return true
        case fieldTags[2]:
            password.becomeFirstResponder()
            return true
        case fieldTags[3]:
            textField.resignFirstResponder()
            return true
        default:
            return true
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let tag = textField.tag
        let text = textField.text ?? ""
        switch tag {
        case fieldTags[0]:
            userInput[0] = text + string
        case fieldTags[1]:
            userInput[1] = text + string
        case fieldTags[2]:
            userInput[2] = text + string
        case fieldTags[3]:
            userInput[3] = text + string
        default:
            break
        }
        return true
    }
}
