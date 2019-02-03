//
//  ExternalURLOpenable.swift
//  FirebaseAuthTraining
//
//  Created by Serg Liamthev on 2/3/19.
//  Copyright © 2019 SergLam. All rights reserved.
//

import UIKit
import SafariServices

protocol ExternalURLOpenable: SFSafariViewControllerDelegate {
    func openURL(_ urlString: String)
}

extension ExternalURLOpenable where Self: UIViewController {
    func openURL(_ urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true, completion: nil)
    }
}
