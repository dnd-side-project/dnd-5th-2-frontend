//
//  UIFont+Ext.swift
//
//  Created by Aaron Lee on 2021/05/21.
//
import UIKit

extension UIFont {

  /// 폰트
  class func font(_ font: Font) -> UIFont? {
    return font.font
  }

}

extension UIFont {
  class func Pretendard(type: PretendardType, size: CGFloat) -> UIFont! {
    guard let font = UIFont(name: type.name, size: size) else {
      return nil
    }
    return font
  }

  public enum PretendardType {
    case Black
    case Bold
    case ExtraBold
    case ExtraLight
    case Light
    case Medium
    case Regular
    case Semibold
    case Thin

    var name: String {
      switch self {
      case .Black:
        return "Pretendard-Black"
      case .Bold:
        return "Pretendard-Bold"
      case .ExtraBold:
        return "Pretendard-ExtraBold"
      case .ExtraLight:
        return "Pretendard-ExtraLight"
      case .Light:
        return "Pretendard-Light"
      case .Medium:
        return "Pretendard-Medium"
      case .Regular:
        return "Pretendard-Regular"
      case .Semibold:
        return "Pretendard-SemiBold"
      case .Thin:
        return "Pretendard-Thin"
      }
    }
  }
}
