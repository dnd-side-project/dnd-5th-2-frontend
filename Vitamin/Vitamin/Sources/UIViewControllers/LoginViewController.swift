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
  @IBOutlet var emailTextFieldResginGestureRecognizer: UITapGestureRecognizer!

  override func viewDidLoad() {
    super.viewDidLoad()

    setupUI()
    setupObserver()
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

  func setupObserver() {
    emailTextField.delegate = self
    emailTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

  }

  @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
    emailTextField.resignFirstResponder()
  }

  @IBAction func lookAround(_ sender: UIButton) {
    // MARK: TODO - Home으로 연결
  }

  func updateContinueButton() {
    continueButton.backgroundColor = continueButton.isEnabled ?
      .black :  UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1)
  }
}

// MARK: UITextField 관련 메소드
extension LoginViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }

  @objc func keyboardWillShow() {
    emailTextFieldResginGestureRecognizer.isEnabled = true
  }

  @objc func keyboardWillHide() {
    emailTextFieldResginGestureRecognizer.isEnabled = false
  }

  @objc func textFieldDidChange(sender: UITextField) {
    if sender == emailTextField {
      continueButton.isEnabled = isValidEmail(emailTextField.text ?? "")
      updateContinueButton()
    }
  }

  func isValidEmail(_ email: String) -> Bool {
      let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

      let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
      return emailPred.evaluate(with: email)
  }
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
