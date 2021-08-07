//
//  UIView+Ext.swift
//
//  Created by Aaron Lee on 2021/05/18.
//
import UIKit

extension UIView {

  class var identifier: String {
      return String(describing: self)
  }

  func makeRounded(radius: CGFloat, at corners: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]) {
      self.layer.cornerRadius = radius
      self.clipsToBounds = true

      self.layer.maskedCorners = corners
  }

  /// 폰트 적용
  func font(_ font: Font) {
    if let button = self as? UIButton {
      button.titleLabel?.font = .font(font)
    } else if let label = self as? UILabel {
      label.font = .font(font)
    } else if let textField  = self as? UITextField {
      textField.font = .font(font)
    } else if let textView = self as? UITextView {
      textView.font = .font(font)
    } else {
      for subview in subviews {
        subview.font(font)
      }
    }
  }
}
