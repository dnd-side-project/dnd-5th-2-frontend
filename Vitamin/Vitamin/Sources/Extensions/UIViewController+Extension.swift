//
//  UIViewController+Extension.swift
//  Vitamin
//
//  Created by Jinhyang on 2021/08/06.
//

import UIKit

extension UIViewController {
    class var identifier: String {
        return String(describing: self)
    }
}
