//
//  UILabel.swift
//  FirebaseAuthTraining
//
//  Created by Serg Liamthev on 7/25/18.
//  Copyright © 2018 SergLam. All rights reserved.
//

import UIKit
import Foundation

extension UILabel{
    func highLightLinksInText(links: [String]){
        let text = (self.text)!
        let underlineAttriString = NSMutableAttributedString(string: text)
        let nstext = text as NSString
        
        for link in links {
            let range = nstext.localizedStandardRange(of: link)
            underlineAttriString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: range)
            underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue , range: range)
        }
        
        self.attributedText = underlineAttriString
    }
}
