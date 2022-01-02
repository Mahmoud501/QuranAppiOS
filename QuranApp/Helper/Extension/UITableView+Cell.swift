//
//  UITableView+Cell.swift
//  BioSmartApp
//
//  Created by Mahmoud on 2/3/20.
//  Copyright © 2020 Mahmoud. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    func register<T: UITableViewCell>(type: T.Type) {
        self.register(type, forCellReuseIdentifier: type.className)
    }
    
    func dequeueCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: T.className, for: indexPath) as! T
    }
}
