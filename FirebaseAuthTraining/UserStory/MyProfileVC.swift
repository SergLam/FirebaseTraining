//
//  MyProfileVC.swift
//  FirebaseAuthTraining
//
//  Created by Serg Liamthev on 8/5/18.
//  Copyright © 2018 SergLam. All rights reserved.
//

import UIKit

class MyProfileVC: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.hideNavBar(false)
    }
    
    func configureUI(){
        self.hideNavBar(true)
    }
}
