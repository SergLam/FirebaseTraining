//
//  JSONConverter.swift
//  FirebaseAuthTraining
//
//  Created by Serg Liamthev on 7/26/18.
//  Copyright © 2018 SergLam. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol JSONAbleType {
    static func fromJSON(_: Any) -> Self
}
