//
//  CustomTextField.swift
//  Vitamin
//
//  Created by Jinhyang on 2021/08/17.
//

import UIKit

class CustomTextField: UITextField {

  var shouldBeEdited: Bool = false {
    willSet {
      if newValue {
        addBorder(color: UIColor(red: 249/255,
                                 green: 71/255,
                                 blue: 71/255,
                                 alpha: 1),
                  borderWidth: 1)

      } else if shouldBeEdited {
        addBorder(color: .textBlack5, borderWidth: 1)
      }
    }
  }

  override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
    let width: CGFloat = 18
    return CGRect(x: frame.width - 12 - width, y: 18, width: width, height: width)
  }

  func setupUI() {
    makeRounded(radius: 13)
    addBorder(color: .textBlack5, borderWidth: 1)
  }
}
