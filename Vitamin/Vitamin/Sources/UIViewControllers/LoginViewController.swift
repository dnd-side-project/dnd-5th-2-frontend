//
//  LoginViewController.swift
//  Vitamin
//
//  Created by Jinhyang on 2021/08/06.
//

import UIKit

// MARK: - TODO 폰트 적용

class LoginViewController: UIViewController {

  @IBOutlet var emailTextField: UITextField!
  @IBOutlet var lookAroundButton: UIButton!
  @IBOutlet var continueButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()

    setupUI()
    emailTextField.delegate = self
  }

  func setupUI() {
    continueButton.setTitleColor(UIColor.black.withAlphaComponent(0.35), for: .disabled)
    continueButton.setTitleColor(UIColor.white, for: .normal)
    updateContinueButton()
    emailTextField.textColor = UIColor.black.withAlphaComponent(0.4)
    emailTextField.addBottomBorder(color: UIColor.black.withAlphaComponent(0.3),
                                   borderWidth: 1,
                                   originYOffset: -7)
    lookAroundButton.addBottomBorder(color: UIColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1),
                                     borderWidth: 1,
                                     originYOffset: 3)
  }

  @IBAction func lookAround(_ sender: UIButton) {
    // MARK: TODO - Home으로 연결
  }

  func updateContinueButton() {
    continueButton.backgroundColor = continueButton.isEnabled ?
      .black :  UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1)
  }
}

extension LoginViewController: UITextFieldDelegate {
  
}

// MARK: - 이후 Extension으로 옮길 것
extension UIView {
  func addBottomBorder(color: UIColor, borderWidth: CGFloat, originYOffset: CGFloat? = nil) {
    let bottomLine = CALayer()
    bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - borderWidth - (originYOffset ?? 0), width: self.frame.size.width, height: borderWidth)
    bottomLine.backgroundColor = color.cgColor
    layer.addSublayer(bottomLine)
  }
}
