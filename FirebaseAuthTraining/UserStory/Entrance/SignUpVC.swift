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

class SignUpVC: UIViewController, UITextFieldDelegate, SFSafariViewControllerDelegate{
    
    let firstName = SkyFloatingLabelTextField()
    let secondName = SkyFloatingLabelTextField()
    let email = SkyFloatingLabelTextField()
    let password = SkyFloatingLabelTextField()
    
    let fieldTags = [1,2,3,4]
    
    let signUpButton = UIButton()
    
    let termsAndConditions = UILabel()
    
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
        self.view.backgroundColor = UIColor.offBlue
        
        firstName.placeholder = R.string.localizable.signUpFirstName()
        firstName.title = R.string.localizable.signUpFirstName()
        firstName.returnKeyType = .next
        firstName.tag = fieldTags[0]
        firstName.delegate = self
        firstName.setEntranceFieldColors()
        
        self.view.addSubview(firstName)
        firstName.snp.makeConstraints{ (make) -> Void in
            make.top.equalToSuperview().offset(10)
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
        secondName.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(firstName.snp.bottom).offset(10)
            make.height.equalTo(46)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        email.placeholder = R.string.localizable.entranceEmail()
        email.title = R.string.localizable.entranceEmail()
        email.returnKeyType = .next
        email.tag = fieldTags[2]
        email.delegate = self
        email.setEntranceFieldColors()
        
        self.view.addSubview(email)
        email.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(secondName.snp.bottom).offset(10)
            make.height.equalTo(46)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        password.placeholder = R.string.localizable.entrancePassword()
        password.title = R.string.localizable.entrancePassword()
        password.returnKeyType = .done
        password.tag = fieldTags[3]
        password.delegate = self
        password.setEntranceFieldColors()
        
        self.view.addSubview(password)
        password.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(email.snp.bottom).offset(10)
            make.height.equalTo(46)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        signUpButton.setTitle(R.string.localizable.signUpButton(), for: .normal)
        signUpButton.backgroundColor = UIColor.overcastBlue
        signUpButton.round(radius: 46/2)
        
        self.view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(password.snp.bottom).offset(25)
            make.height.equalTo(46)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
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
        termsAndConditions.snp.makeConstraints{ (make) -> Void in
            make.bottom.equalToSuperview().offset(-25)
            make.height.equalTo(46)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
    }
    
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
