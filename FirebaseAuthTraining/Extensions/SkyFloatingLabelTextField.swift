//
//  SkyFloatingLabelTextField.swift
//  FirebaseAuthTraining
//
//  Created by Serg Liamthev on 7/24/18.
//  Copyright © 2018 SergLam. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

extension SkyFloatingLabelTextField{
    
    func setEntranceFieldColors(){
        self.tintColor = UIColor.overcastBlue // the color of the blinking cursor
        self.textColor = UIColor.darkGrey
        self.lineColor = UIColor.lightGrey
        self.selectedTitleColor = UIColor.overcastBlue
        self.selectedLineColor = UIColor.overcastBlue
    }
}
