//
//  EntranceVC.swift
//  FirebaseAuthTraining
//
//  Created by Serg Liamthev on 7/22/18.
//  Copyright © 2018 SergLam. All rights reserved.
//

import UIKit
import SnapKit

class EntranceVC: UIViewController {
    
    private var childControllers: [UIViewController] = []
    private let containerView = UIView()
    private let pages = [R.string.localizable.signInButton(), R.string.localizable.signUpButton()]
    private let segment = UISegmentedControl()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildViewControllers()
        configureUI()
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    private func setupChildViewControllers() {
        let signInVC = SignInVC(parent: self)
        let signUpVC = SignUpVC(parent: self)
        
        childControllers.append(contentsOf: [signInVC, signUpVC])
        
        children.forEach {
            addChild($0)
            $0.didMove(toParent: self)
        }
    }
    
    private func configureUI(){
        self.view.backgroundColor = .cyan
        for (index, page) in pages.enumerated() {
          segment.insertSegment(withTitle: page, at: index, animated: false)
        }
        segment.layer.cornerRadius = 5.0
        segment.backgroundColor = UIColor.white
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(self.changeVisibleVC(sender:)), for: UIControl.Event.valueChanged)

        self.view.addSubview(segment)
        segment.snp.makeConstraints{ (make) -> Void in
            make.height.equalTo(30)
            if #available(iOS 11.0, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            } else {
                make.top.equalTo(view.snp.topMargin).offset(20)
            }
            make.left.equalTo(self.view).offset(10)
            make.right.equalTo(self.view).offset(-10)
        }
    
        self.view.addSubview(containerView)
        containerView.snp.makeConstraints{ make -> Void in
            make.top.equalTo(segment.snp.bottom).offset(10)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
        
        setViewControllerToView(vc: childControllers[1])
        setViewControllerToView(vc: childControllers[0])

    }
    
   @objc func changeVisibleVC(sender: UISegmentedControl){
    switch sender.selectedSegmentIndex {
        // Such approach didn't give memory leaks
    case 0:
        childControllers[0].view.alpha = 1
        childControllers[1].view.alpha = 0
    case 1:
        childControllers[0].view.alpha = 0
        childControllers[1].view.alpha = 1
    default:
        break
    }
    }
    
    func setViewControllerToView(vc: UIViewController){
        vc.view.frame = self.containerView.bounds
        self.containerView.addSubview(vc.view)
    }
    
    func showMainVC(){
        self.present(MainVC(), animated: true, completion: nil)
    }
    
}
