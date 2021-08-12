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
    let isEnable = isEnalbeContinueButton()
    continueButton.isEnabled = isEnable

    switch viewType {
    case .email:
      commonTextField.textColor = isEnable ? textFieldValidColor : textFieldInvalidColor
    case .signUpPassword:
      passwordTextField.textColor = isEnable ? textFieldValidColor : textFieldInvalidColor
      checkPasswordTextField.textColor = isEnable ? textFieldValidColor : textFieldInvalidColor
    case .loginPassword:
      break
    case .nickName:
      continueButton.isEnabled = {
        if let text = sender.text,
           !text.isEmpty,
           text.count < 7 {
          return true
        } else {
          return false
        }
      }()
    default:
      break
    }

    updateContinueButton()
  }

  func isEnalbeContinueButton() -> Bool {
    switch viewType {
    case .email:
      let email = commonTextField.text ?? ""
      let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
      let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
      return emailPred.evaluate(with: email)
    case .signUpPassword:
      guard let passwordTextFieldText = passwordTextField.text,
            !passwordTextFieldText.isEmpty,
            let checkPasswordTextFieldText = checkPasswordTextField.text,
            !checkPasswordTextFieldText.isEmpty,
            passwordTextFieldText == checkPasswordTextFieldText,
            passwordTextFieldText.count >= 6,
            passwordTextFieldText.count < 15 else { return false }
      return true
    case .loginPassword:
      guard let passwordTextFieldText = passwordTextField.text,
            !passwordTextFieldText.isEmpty else { return false }
      return true
    case .nickName:
      let nickNameRegEx = "[A-Z0-9a-z가-힣]{1,8}"
      guard  let text = commonTextField.text,
             NSPredicate(format: "SELF MATCHES %@", nickNameRegEx).evaluate(with: text) else { return false }
      return true
    default:
      return false
    }
  }
}

// MARK: - 네트워크
extension LoginViewController {
  func checkEmail(email: String, completion: @escaping (Bool) -> Void) {
    LoginManager.shared.checkEmailExists(email: email) { success in
      completion(success)
    }
  }

  func login(completion: @escaping (Bool) -> Void) {
    guard let loginUser = user else { return }
    LoginManager.shared.login(loginUser: loginUser) { success in
      guard success else {
        completion(false)
        return
      }
      completion(true)
    }
  }
}
