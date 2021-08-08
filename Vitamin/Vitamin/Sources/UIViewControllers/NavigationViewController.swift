//
//  RootNavigationViewController.swift
//  Vitamin
//
//  Created by Jinhyang on 2021/08/08.
//

import UIKit
import Alamofire

class NavigationViewController: UINavigationController {

  override func viewDidLoad() {
    super.viewDidLoad()
    setRootViewController()
    setNavigationBarHidden(true, animated: false)
    navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationBar.shadowImage = UIImage()
    navigationBar.backgroundColor = .clear
    navigationBar.titleTextAttributes = [
      NSAttributedString.Key.font: UIFont(name: "Pretendard-SemiBold", size: 16) ?? .systemFont(ofSize: 16)
    ]

    UINavigationBar.appearance().backIndicatorImage = UIImage(named: "backButton")
    UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "backButton")
  }

  func setRootViewController() {
    LoginManager.shared.login { success in
      guard success,
            let user = LoginManager.shared.currentUser else {
        let storyboard = UIStoryboard(name: Constants.StoryboardName.SignUp.rawValue, bundle: nil)
        if let rootVC = storyboard.instantiateViewController(withIdentifier: LoginViewController.identifier) as? LoginViewController {
          rootVC.viewType = .email
          self.viewControllers = [rootVC]
        }
        return
      }

      if let _ = user.type {
        // MARK: TODO home으로 이동
      } else {
        // MARK: TODO 온보딩으로 이동
      }
    }
  }

  func setRootViewController<T: UIViewController>(vcType: T.Type, storyboardName: String) {
    let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
    if let rootVC = storyboard.instantiateViewController(withIdentifier: T.identifier) as? T {
      self.viewControllers = [rootVC]
    }
  }
}
