//
//  MyProfileTableDelegate.swift
//  FirebaseAuthTraining
//
//  Created by Serg Liamthev on 9/23/18.
//  Copyright © 2018 SergLam. All rights reserved.
//

import UIKit

final class MyProfileTableDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    let headers: [[String]] = [["Phone", "Email"], ["Change password", "FAQ", "Contact Us"], ["Log out"]]
    
    let user: UserModel? = nil
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headers[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return headers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .value1, reuseIdentifier: "my_profile_cell")
        cell.textLabel?.text = headers[indexPath.section][indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        switch indexPath.section {
        case 0:
            switch indexPath.row{
            case 0:
                cell.detailTextLabel?.text = user?.email ?? "(555) 555-5555"
                return cell
            case 1:
                cell.detailTextLabel?.text = user?.email ?? "(555) 555-5555"
                return cell
            default:
                return cell
            }
        case 1:
            switch indexPath.row{
            case 0:
                return cell
            case 1:
                return cell
            case 2:
                return cell
            default:
                return cell
            }
        case 2:
            switch indexPath.row{
            case 0:
                cell.accessoryType = .none
                cell.textLabel?.textColor = UIColor.red
                return cell
            default:
                return cell
            }
        default:
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.tableDefaultColor
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        switch section {
        case 2:
            let view = UIView()
            view.backgroundColor = UIColor.tableDefaultColor
            return view
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 2:
            return 15
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row\(indexPath.row) at section\(indexPath.section)")
    }
    
}
