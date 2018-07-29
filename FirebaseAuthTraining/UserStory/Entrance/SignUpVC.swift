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

class SignUpVC: UIViewController, UITextFieldDelegate, SFSafariViewControllerDelegate, GIDSignInUIDelegate {
    
    let viewModel = EntranceVM.sharedInstance
    
    let firstName = SkyFloatingLabelTextField()
    let secondName = SkyFloatingLabelTextField()
    let email = SkyFloatingLabelTextField()
    let password = SkyFloatingLabelTextField()
    
    let fieldTags = [1,2,3,4]
    
    let signUpButton = UIButton()
    let fbButton = UIButton(type: .custom)
    let gmailButton = GIDSignInButton()
    
    let termsAndConditions = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
        
        firstName.placeholder = R.string.localizable.signUpFirstName()
        firstName.title = R.string.localizable.signUpFirstName()
        firstName.returnKeyType = .next
        firstName.tag = fieldTags[0]
        firstName.delegate = self
        firstName.setEntranceFieldColors()
        
        self.view.addSubview(firstName)
        firstName.snp.remakeConstraints{ (make) -> Void in
        make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(10)
            make.height.equalTo(46)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        secondName.placeholder = R.string.localizable.signUpSecondName()
        secondName.title = R.string.localizable.signUpSecondName()
        secondName.returnKeyType = .next
        secondName.tag = fieldTags[1]
        secondName.delegate = self
        secondName.setEntranceFieldColors()
        
        self.view.addSubview(secondName)
        secondName.snp.remakeConstraints{ (make) -> Void in
            make.top.equalTo(firstName.snp.bottom).offset(10)
            make.height.equalTo(46)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        email.placeholder = R.string.localizable.entranceEmail()
        email.title = R.string.localizable.entranceEmail()
        email.autocapitalizationType = .none
        email.returnKeyType = .next
        email.tag = fieldTags[2]
        email.delegate = self
        email.setEntranceFieldColors()
        
        self.view.addSubview(email)
        email.snp.remakeConstraints{ (make) -> Void in
            make.top.equalTo(secondName.snp.bottom).offset(10)
            make.height.equalTo(46)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        password.placeholder = R.string.localizable.entrancePassword()
        password.title = R.string.localizable.entrancePassword()
        password.isSecureTextEntry = true
        password.returnKeyType = .done
        password.tag = fieldTags[3]
        password.delegate = self
        password.setEntranceFieldColors()
        
        self.view.addSubview(password)
        password.snp.remakeConstraints{ (make) -> Void in
            make.top.equalTo(email.snp.bottom).offset(10)
            make.height.equalTo(46)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        signUpButton.setTitle(R.string.localizable.signUpButton(), for: .normal)
        signUpButton.backgroundColor = UIColor.overcastBlue
        signUpButton.round(radius: 46/2)
        signUpButton.addTarget(self, action: #selector(self.signUp), for: .touchUpInside)
        
        self.view.addSubview(signUpButton)
        signUpButton.snp.remakeConstraints{ (make) -> Void in
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
            make.top.equalTo(signUpButton.snp.bottom).offset(25)
            make.height.equalTo(46)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        self.view.addSubview(gmailButton)
        gmailButton.snp.remakeConstraints{ (make) -> Void in
            make.top.equalTo(fbButton.snp.bottom).offset(25)
            make.height.equalTo(46)
            make.width.equalTo(textWidth + 23)
            make.centerX.equalTo(self.view.center.x)
        }
        
        termsAndConditions.numberOfLines = 2
        termsAndConditions.text = R.string.localizable.signUpRules()
        termsAndConditions.textAlignment = .center
        termsAndConditions.textColor = UIColor.overcastBlue
        termsAndConditions.font = UIFont.systemFont(ofSize: 14)
        termsAndConditions.highLightLinksInText(links: [R.string.localizable.signUpTerms(), R.string.localizable.signUpPrivacy()])
        termsAndConditions.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapTermsAndConditionsLabel))
        termsAndConditions.addGestureRecognizer(tap)
        
        self.view.addSubview(termsAndConditions)
        termsAndConditions.snp.remakeConstraints{ (make) -> Void in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin).offset(-25)
            make.height.equalTo(46)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
    }
    
    // MARK: Facebook login
    
    @objc func facebookLogin(){
       viewModel.signUpViaFB()
    }
    
   @objc func signUp(){
    let user = UserModel()
    user.firstName = self.firstName.text ?? ""
    user.secondName = self.secondName.text ?? ""
    user.email = self.email.text ?? ""
    user.password = self.password.text ?? ""
    let validation = viewModel.validateInputs(user: user)
    if(validation.0){
        print("Sign Up")
        viewModel.signUp(email: email.text!, password: password.text!){ completion in
            if(completion){
                print("Success")
            }
        }
    } else {
        self.showError(error: validation.1)
    }
    }
    
    // MARK: TextFields delegate methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let tag = textField.tag
        switch tag {
        case fieldTags[0]:
            secondName.becomeFirstResponder()
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
    
    // MARK: Open bottom likns handler
    
    @objc func tapTermsAndConditionsLabel(){
        let text = (termsAndConditions.text)!
        let termsRange = (text as NSString).range(of: R.string.localizable.signUpTerms())
        let privacyRange = (text as NSString).range(of: R.string.localizable.signUpPrivacy())
        
        if let gesture = termsAndConditions.gestureRecognizers?[0] as? UITapGestureRecognizer{
            if gesture.didTapAttributedTextInLabel(label: termsAndConditions, inRange: termsRange) {
                if let url = URL.init(string: "https://www.google.com/"){
                    let svc = SFSafariViewController(url: url)
                    svc.delegate = self
                    UIApplication.topViewController()?.present(svc, animated: true, completion: nil)
                }
            } else if gesture.didTapAttributedTextInLabel(label: termsAndConditions, inRange: privacyRange) {
                if let url = URL.init(string: "https://github.com/"){
                    let svc = SFSafariViewController(url: url)
                    svc.delegate = self
                    UIApplication.topViewController()?.present(svc, animated: true, completion: nil)
                }
            }
        }
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true, completion: nil)
    }
    
}
