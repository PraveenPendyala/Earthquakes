//
//  UITableViewCell+Extension.swift
//  Earthquakes
//
//  Created by Praveen on 8/13/22.
//

import UIKit

protocol CellNibLoadable {
    static var cellIdentifier: String { get }
    static var nibName: String { get }
}

extension CellNibLoadable {
    static var cellIdentifier: String {
        return String(describing: self)
    }
    static var nibName: String {
        return String(describing: self)
    }
}

extension UITableViewCell : CellNibLoadable {
    static func register(with tableView: UITableView) {
        let nib = UINib(nibName: nibName, bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
    }
}
