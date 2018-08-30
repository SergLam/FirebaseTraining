//
//  MyProfileVC.swift
//  FirebaseAuthTraining
//
//  Created by Serg Liamthev on 8/5/18.
//  Copyright © 2018 SergLam. All rights reserved.
//

import UIKit
import Eureka
import SnapKit

class MyProfileVC: UIViewController {
    
    let profileImage: UIImageView = UIImageView()
    let userName: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func configureUI(){
        self.hideNavBar(false)
        self.navigationItem.title = "My profile"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editProfile))
        self.view.addSubview(profileImage)
        profileImage.image = R.image.profile_tab()
        profileImage.snp.remakeConstraints{ (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(20)
            make.height.equalTo(80)
            make.width.equalTo(80)
            make.centerX.equalTo(self.view.center.x)
        }
        
    }
    
    @objc func editProfile(){
        print("TODO: Edit profile")
    }
    
}
