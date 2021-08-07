//
//  UIDevice+Ext.swift
//
//  Created by Aaron Lee on 2021/08/06.
//

import UIKit

extension UIDevice {

  static let currentLocale = Locale.preferredLanguages[0]

  var modelName: String {
    var systemInfo = utsname()
    uname(&systemInfo)
    let machineMirror = Mirror(reflecting: systemInfo.machine)
    let identifier = machineMirror.children.reduce("") { identifier, element in
      guard let value = element.value as? Int8, value != 0 else { return identifier }
      return identifier + String(UnicodeScalar(UInt8(value)))
    }
    return identifier
  }

  // Checks if device is an iPhone 5s, iPhone SE, or iPod Touch 6th gen
  static var isSmallDevice: Bool {
    return UIDevice.current.modelName == "iPhone6,1"
      || UIDevice.current.modelName == "iPhone6,2"
      || UIDevice.current.modelName == "iPod7,1"
      || UIDevice.current.modelName == "iPhone8,4"
  }
}
