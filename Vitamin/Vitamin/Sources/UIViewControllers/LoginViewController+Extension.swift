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
    switch viewType {
    case .email:
      let isEnable = isEnalbeContinueButton()
      continueButton.isEnabled = isEnable
      commonTextField.textColor = isEnable ? textFieldValidColor : textFieldInvalidColor
    case .signUpPassword:
      let isEnable: Bool = { // MARK: TODO 비밀번호 규칙 추가
        if let passwordTextFieldText = passwordTextField.text,
           !passwordTextFieldText.isEmpty,
           let checkPasswordTextFieldText = checkPasswordTextField.text,
           !checkPasswordTextFieldText.isEmpty,
           passwordTextFieldText == checkPasswordTextFieldText {
          return true
        } else {
          return false
        }
      }()
      continueButton.isEnabled = isEnable
      passwordTextField.textColor = isEnable ? textFieldValidColor : textFieldInvalidColor
      checkPasswordTextField.textColor = isEnable ? textFieldValidColor : textFieldInvalidColor
    case .loginPassword:
      continueButton.isEnabled = {
        if let passwordTextFieldText = passwordTextField.text,
           !passwordTextFieldText.isEmpty {
          return true
        } else {
          return false
        }
      }()
    case .nickName:
      continueButton.isEnabled = {
        if let text = sender.text,
           !text.isEmpty {
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
      return isValidEmail()
    case .signUpPassword:
      return passwordTextField.text == checkPasswordTextField.text
    default:
      return false
    }
  }

  func isValidEmail() -> Bool {
    let email = commonTextField.text ?? ""
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
  }
}

// MARK: - 네트워크
extension LoginViewController {
  func checkEmail(completion: @escaping (Bool) -> Void) {
    guard let loginUser = loginUser else {
      completion(true)
      return
    }

    // MARK: TODO - email 유무 확인하고 completion 실행
    completion(true)
  }

  func login(completion: @escaping (Bool) -> Void) {
    guard let loginUser = loginUser else { return }
    LoginManager.shared.login(loginUser: loginUser) { success in
      guard success else {
        completion(false)
        return
      }
      completion(true)
    }
  }
}
