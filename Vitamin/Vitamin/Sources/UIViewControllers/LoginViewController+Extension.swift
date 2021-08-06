//
//  LoginViewController+Extension.swift
//  Vitamin
//
//  Created by Jinhyang on 2021/08/07.
//

import UIKit

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

// MARK: - 네트워크
extension LoginViewController {

}
