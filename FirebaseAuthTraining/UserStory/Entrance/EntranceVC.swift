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
    
    var childControllers: [UIViewController] = []
    let containerView = UIView()
    let pages = [R.string.localizable.signInButton(), R.string.localizable.signUpButton()]
    let segment = UISegmentedControl()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let signInVC = SignInVC()
        let signUpVC = SignUpVC()
        
        childControllers.append(contentsOf: [signInVC, signUpVC])
        
        childViewControllers.forEach {
            addChildViewController($0)
            $0.didMove(toParentViewController: self)
        }
        
        configureUI()
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureUI(){
        for (index, page) in pages.enumerated() {
          segment.insertSegment(withTitle: page, at: index, animated: false)
        }
        segment.layer.cornerRadius = 5.0
        segment.backgroundColor = UIColor.white
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(self.changeVisibleVC(sender:)), for: UIControlEvents.valueChanged)

        self.view.addSubview(segment)
        segment.snp.makeConstraints{ (make) -> Void in
            make.height.equalTo(30)
        make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
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
    print("Clicked \(sender.titleForSegment(at: sender.selectedSegmentIndex)!)")
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
    
}
