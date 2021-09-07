//
//  MainVC.swift
//  FirebaseAuthTraining
//
//  Created by Serg Liamthev on 8/3/18.
//  Copyright © 2018 SergLam. All rights reserved.
//

import UIKit
import ESTabBarController_swift

final class MainVC: ESTabBarController {
    
    private let mapVC = MapVC()
    
    private let chatsVC = ChatsVC()
    
    private let usersVC = UsersVC()
    
    private let myProfileVC = MyProfileVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func configureUI(){
       configureTabBar()
    }
    
    func configureTabBar(){
        mapVC.tabBarItem = ESTabBarItem(ESTabBarItemContentView(), title: "Map", image: R.image.map_tab(), selectedImage: nil, tag: 0)
        chatsVC.tabBarItem = ESTabBarItem(ESTabBarItemContentView(), title: "Chats", image: R.image.chat_tab(), selectedImage: nil, tag: 1)
        usersVC.tabBarItem = ESTabBarItem(ESTabBarItemContentView(), title: "Contacts", image: R.image.contacts_tab(), selectedImage: nil, tag: 2)
        myProfileVC.tabBarItem = ESTabBarItem(ESTabBarItemContentView(), title: "My Profile", image: R.image.profile_tab(), selectedImage: nil, tag: 3)
        let controllers = [mapVC, chatsVC, usersVC, myProfileVC]
        self.tabBar.isTranslucent = false
        self.viewControllers = controllers.map { UINavigationController(rootViewController: $0)}
        self.selectedIndex = 3
    }
}
