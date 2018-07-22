//
//  EntranceVC.swift
//  FirebaseAuthTraining
//
//  Created by Serg Liamthev on 7/22/18.
//  Copyright © 2018 SergLam. All rights reserved.
//

import UIKit
import SnapKit
import Eureka

class EntranceVC: FormViewController {
    
    let signInVC = SignInVC()
    
    let signUpVC = SignUpVC()
    
    let containerView = UIView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
        view.backgroundColor = .gray
//        let pages = ["Sign In", "Sign Up"]
//        let segment = UISegmentedControl.init(items: pages)
//        segment.layer.cornerRadius = 5.0
//        segment.backgroundColor = UIColor.white
//        segment.selectedSegmentIndex = 0
//        segment.addTarget(self, action: #selector(self.changeVisibleVC(sender:)), for: UIControlEvents.valueChanged)
//
//        self.view.addSubview(segment)
//        segment.snp.makeConstraints{ (make) -> Void in
//            make.height.equalTo(30)
//        make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
//            make.left.equalTo(self.view).offset(10)
//            make.right.equalTo(self.view).offset(-10)
//        }
        form +++ Section("Section1")
            <<< TextRow(){ row in
                row.title = "Text Row"
                row.placeholder = "Enter text here"
            }
            <<< PhoneRow(){
                $0.title = "Phone Row"
                $0.placeholder = "And numbers here"
            }
            +++ Section("Section2")
            <<< DateRow(){
                $0.title = "Date Row"
                $0.value = Date(timeIntervalSinceReferenceDate: 0)
        }
        
    }
    
   @objc func changeVisibleVC(sender: UISegmentedControl){
        print("Click")
    }
    
}
