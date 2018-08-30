//
//  ZoomButtons.swift
//  FirebaseAuthTraining
//
//  Created by Serg Liamthev on 8/19/18.
//  Copyright © 2018 SergLam. All rights reserved.
//

import UIKit
import SnapKit

class ZoomButtonsView: UIView {
    
    let screenSize = UIScreen.main.bounds
    
    let zoomInButton = UIView()
    let zoomOutButton = UIView()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        self.addSubview(zoomInButton)
        zoomInButton.backgroundColor = .googleMapsButtons
        let zoomInTap = UITapGestureRecognizer(target: self, action:  #selector(self.zoomIn))
        zoomInButton.addGestureRecognizer(zoomInTap)
        zoomInButton.isUserInteractionEnabled = true
        zoomInButton.snp.makeConstraints{ (make) -> Void in
            make.width.equalTo(self.bounds.width)
            make.height.equalTo(self.bounds.height/2)
            make.top.equalTo(self.snp.top)
        }
        self.addSubview(zoomOutButton)
        zoomOutButton.backgroundColor = .googleMapsButtons
        let zoomOutTap = UITapGestureRecognizer(target: self, action:  #selector(self.zoomOut))
        zoomOutButton.addGestureRecognizer(zoomOutTap)
        zoomOutButton.isUserInteractionEnabled = true
        zoomOutButton.snp.makeConstraints{ (make) -> Void in
            make.width.equalTo(self.bounds.width)
            make.height.equalTo(self.bounds.height/2)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func zoomIn(sender : UITapGestureRecognizer) {
        print("ZoomIn")
    }
    
    @objc func zoomOut(sender : UITapGestureRecognizer) {
        print("ZoomOut")
    }
}
