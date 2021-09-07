//
//  MyProfileVC.swift
//  FirebaseAuthTraining
//
//  Created by Serg Liamthev on 8/5/18.
//  Copyright © 2018 SergLam. All rights reserved.
//

import UIKit
import SnapKit

final class MyProfileVC: UIViewController {
        
    let viewModel = MyProfileVM()
    let user_info_delegate = MyProfileTableDelegate()
    
    let profileImage: UIImageView = UIImageView()
    let userName: UILabel = UILabel()
    let user_info: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideNavBar(false)
        user_info.delegate = user_info_delegate
        user_info.dataSource = user_info_delegate
//        viewModel.loadUser(){ completion in
//            if(completion){
//                self.viewModel.updateUser(user: self.viewModel.user!){ completion in
//                    if(completion){
//
//                    }
//                }
//            }
//        }

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func configureUI(){
        self.navigationItem.title = "My profile"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editProfile))
        self.view.addSubview(profileImage)
        profileImage.image = R.image.profile_tab()
        profileImage.snp.remakeConstraints{ (make) -> Void in
            if #available(iOS 11.0, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(10)
            } else {
                // Fallback on earlier versions
            make.top.equalTo(view.snp.topMargin).offset((self.navigationController?.navigationBar.frame.size.height)! + 10)
            }
            make.height.equalTo(80)
            make.width.equalTo(80)
            make.centerX.equalTo(self.view.center.x)
        }
        self.view.addSubview(userName)
        userName.text = "Test User Name"
        userName.textAlignment = .center
        userName.snp.remakeConstraints{ (make) -> Void in
            make.top.equalTo(profileImage.snp.bottom).offset(10)
            make.centerX.equalTo(self.view.center.x)
            make.height.equalTo(userName.font.lineHeight)
            make.width.equalTo(self.view.frame.width)
        }
        self.view.addSubview(user_info)
        user_info.isScrollEnabled = false
        let footer = UIView()
        footer.backgroundColor = UIColor.tableDefaultColor
        user_info.tableFooterView = footer
        user_info.snp.remakeConstraints{ (make) -> Void in
            make.top.equalTo(userName.snp.bottom).offset(10)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.height.equalTo(user_info.contentSize.height)
        }
    }
    
    
    @objc func editProfile(){
        print("TODO: Edit profile")
    }
    
}
