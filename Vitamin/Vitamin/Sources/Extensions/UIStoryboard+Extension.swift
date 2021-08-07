//
//  UIStoryboard+Extension.swift
//  Vitamin
//
//  Created by Jinhyang on 2021/08/08.
//

import UIKit

extension UIStoryboard {
  class var identifier: String {
      return String(describing: self)
  }
}
