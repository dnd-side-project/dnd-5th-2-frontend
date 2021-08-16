//
//  UINavigationController+Extension.swift
//  Vitamin
//
//  Created by Jinhyang on 2021/08/16.
//

import UIKit

extension UINavigationController {
  func changeRootViewController<T: UIViewController>(vcType: T.Type, storyboardName: Constants.StoryboardName) {
    let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)
    if let rootVC = storyboard.instantiateViewController(withIdentifier: vcType.identifier) as? T {
      self.setViewControllers([rootVC], animated: true)
    }
  }
}
