//
//  LoginViewController.swift
//  Vitamin
//
//  Created by Jinhyang on 2021/08/06.
//

import UIKit

// MARK: - TODO 폰트 적용

class LoginViewController: UIViewController {

  @IBOutlet var emailTextField: CustomTextField!
  @IBOutlet var lookAroundButton: UIButton!
  @IBOutlet var continueButton: UIButton!
  @IBOutlet var emailTextFieldResginGestureRecognizer: UITapGestureRecognizer!
  @IBOutlet var titleLabel: UILabel!

  var viewType: ViewType?
  var loginUser: LoginUser?

  let textFieldValidColor: UIColor = .textBlack1
  let textFieldInvalidColor: UIColor = .textBlack5

  enum ViewType {
    case email
    case nickName
    case loginPassword
    case signUpPassword
    case findPassword

    var titleLabelText: String {
      switch self {
      case .email:
        return "이메일을 입력해주세요"
      case .loginPassword, .signUpPassword:
        return "비밀번호를 입력해주세요"
      default:
        return ""
      }
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setupUI()
    setupObserver()
  }

  func setupUI() {
    continueButton.setTitleColor(UIColor.textBlack5, for: .disabled)
    continueButton.setTitleColor(UIColor.white, for: .normal)
    continueButton.makeRounded(radius: 13)
    emailTextField.makeRounded(radius: 13)
    emailTextField.addBorder(color: UIColor(red: 224/255, green: 224/255, blue: 229/255, alpha: 1), borderWidth: 1)
    updateContinueButton()
    lookAroundButton.addBottomBorder(color: UIColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1),
                                     borderWidth: 1,
                                     originYOffset: -3)
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

  @IBAction func changeViewType(_ sender: UIButton) {
    guard let viewType = viewType else { return }

    switch viewType {
    case .email:
      // MARK: TODO; 이메일 등록 여부 확인 후, signUp이나 login으로 넘어가기
      print(">")
    case .findPassword:
      // MARK: TODO ; 비밀번호 찾기 기능
      print(">")
    case .loginPassword:
      requestLogin()
    case .nickName:
      // MARK: TODO ; 회원가입 request 요청하고 Home으로 이동하기
      print(">")
    case .signUpPassword:
      self.viewType = .nickName
    }
  }

  func updateContinueButton() {
    continueButton.backgroundColor = continueButton.isEnabled ?
      .black :  UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1)
  }

  func updateUIByViewType() {
//    guard let viewType = viewType else { return }
//    switch viewType {
//    case .loginPassword:
//      <#code#>
//    default:
//      <#code#>
//    }
  }
}

class CustomTextField: UITextField {
  override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
    let width: CGFloat = 18
    return CGRect(x: frame.width - 12 - width, y: 18, width: width, height: width)
  }
}
