//
//  Extensions.swift
//  FireBaseChatApp
//
//  Created by Alvin  on 24/12/2022.
//

import Foundation
import UIKit

extension UITableView {
    func registerCells(str: String...) {
        str.forEach {
            self.register(UINib(nibName: $0, bundle: nil), forCellReuseIdentifier: $0)
        }
    }
}

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionView {
    func registerCells(str: String...) {
        str.forEach {
            self.register(UINib(nibName: $0, bundle: nil), forCellWithReuseIdentifier: $0)
        }
    }
}

extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
