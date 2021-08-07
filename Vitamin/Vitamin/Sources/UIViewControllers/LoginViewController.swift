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
  @IBOutlet var passwordTextField: CustomTextField!
  @IBOutlet var checkPasswordTextField: CustomTextField!
  @IBOutlet var continueButtonTopToEmailTextFieldConstraint: NSLayoutConstraint!

  lazy var loginUser: LoginUser? = LoginUser(email: "", password: "")
  let textFieldValidColor: UIColor = .textBlack1
  let textFieldInvalidColor: UIColor = .textBlack5
  var viewType: ViewType? {
    didSet {
      updateViewByViewType()
    }
  }

  enum ViewType {
    case email
    case nickName
    case loginPassword
    case signUpPassword
    case findPassword

    var titleLabelText: String {
      switch self {
      case .email:
        return "반가워요.\n꿀꺽을 시작해볼까요?\n이메일을 부탁해요."
      case .loginPassword:
        return "우리 또 만났네요.\n비밀번호를 써주세요."
      case .signUpPassword:
        return "우리 초면이네요.\n비밀번호는 뭘로 할까요?"
      default:
        return ""
      }
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setupUI()
    setupObserver()

    viewType = .email  // MARK: For Test
  }

  func setupUI() {
    continueButton.translatesAutoresizingMaskIntoConstraints = false
    continueButton.setTitleColor(UIColor.textBlack5, for: .disabled)
    continueButton.setTitleColor(UIColor.white, for: .normal)
    continueButton.makeRounded(radius: 13)
    emailTextField.setupUI()
    passwordTextField.setupUI()
    checkPasswordTextField.setupUI()
    updateContinueButton()
    lookAroundButton.addBottomBorder(color: UIColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1),
                                     borderWidth: 1,
                                     originYOffset: -3)
  }

  func setupObserver() {
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
    switch self.viewType {
    case .email:
      // MARK: TODO; 이메일 등록 여부 확인 후, signUp이나 login으로 넘어가기
      loginUser?.email = emailTextField.text
      checkEmail { exist in
        self.viewType = exist ? .loginPassword : .signUpPassword
      }
    case .findPassword:
      // MARK: TODO ; 비밀번호 찾기 기능
      print(">")
    case .loginPassword:
      login()
    case .nickName:
      // MARK: TODO ; 회원가입 request 요청하고 Home으로 이동하기
      print(">")
    case .signUpPassword:
      self.viewType = .nickName
    default:
      break
    }
  }

  func updateContinueButton() {
    continueButton.backgroundColor = continueButton.isEnabled ?
      .black :  UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1)
  }

  func updateViewByViewType() {
    emailTextField.isHidden = true
    passwordTextField.isHidden = true
    checkPasswordTextField.isHidden = true

    switch viewType {
    case .email:
      emailTextField.isHidden = false
    case .signUpPassword:
      passwordTextField.isHidden = false
      checkPasswordTextField.isHidden = false
      continueButtonTopToEmailTextFieldConstraint.isActive = false
      continueButton.topAnchor.constraint(equalTo: checkPasswordTextField.bottomAnchor, constant: 15).isActive = true
    default:
      break
    }

    titleLabel.text = viewType?.titleLabelText
  }
}

class CustomTextField: UITextField {
  override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
    let width: CGFloat = 18
    return CGRect(x: frame.width - 12 - width, y: 18, width: width, height: width)
  }

  func setupUI() {
    makeRounded(radius: 13)
    addBorder(color: .textBlack5, borderWidth: 1)
  }
}
