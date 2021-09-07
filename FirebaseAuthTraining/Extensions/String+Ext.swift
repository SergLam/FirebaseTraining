//
//  StringParams.swift
//  FirebaseAuthTraining
//
//  Created by Serg Liamthev on 7/29/18.
//  Copyright © 2018 SergLam. All rights reserved.
//

import UIKit

extension String{
    func widthOfString(font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func heightOfString(font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
    
    func sizeOfString(font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }
    
    func isValidEmail() -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        let regExp = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{8,}$"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", regExp)
        return emailPredicate.evaluate(with: self)
    }
    
    func notEmpty() -> Bool {
        let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return !trimmed.isEmpty
    }
}
