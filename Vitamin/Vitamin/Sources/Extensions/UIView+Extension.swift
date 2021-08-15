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

  func addBottomBorder(color: UIColor, borderWidth: CGFloat, originYOffset: CGFloat? = nil) {
    let bottomLine = CALayer()
    bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - borderWidth - (originYOffset ?? 0), width: self.frame.size.width, height: borderWidth)
    bottomLine.backgroundColor = color.cgColor
    layer.addSublayer(bottomLine)
  }

  func addBorder(color: UIColor, borderWidth: CGFloat) {
    layer.borderColor = color.cgColor
    layer.borderWidth = borderWidth
  }

  // MARK: TODO 하드코딩 바꾸기
  func applyCircleShadow(cornerRadius: CGFloat,
                         shadowRadius: CGFloat = 2,
                         shadowOpacity: Float = 0.3,
                         shadowColor: CGColor = UIColor.white.cgColor,
                         shadowOffset: CGSize = CGSize.zero) {
    layer.cornerRadius = cornerRadius
    layer.masksToBounds = false
    layer.shadowColor = shadowColor
    layer.shadowOffset = shadowOffset
    layer.shadowRadius = shadowRadius
    layer.shadowOpacity = shadowOpacity
  }
}
