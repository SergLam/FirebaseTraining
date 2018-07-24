//
//  RoundedButton.swift
//  FirebaseAuthTraining
//
//  Created by Serg Liamthev on 7/24/18.
//  Copyright © 2018 SergLam. All rights reserved.
//

import UIKit

extension UIButton{
    func round(radius: CGFloat){
       self.layer.cornerRadius = radius
       self.clipsToBounds = true
    }
}
