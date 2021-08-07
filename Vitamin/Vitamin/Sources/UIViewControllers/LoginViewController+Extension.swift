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
  func requestLogin() {
    guard let loginUser = loginUser else { return }
    LoginManager.shared.login(loginUser: loginUser) { success in
      guard success else {
        // MARK: TODO - 로그인 오류 핸들링
        return
      }

      // MARK: TODO - Home으로 이동하는 함수 구현
    }
  }
}
