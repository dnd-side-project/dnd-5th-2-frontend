//
//  LoginViewController.swift
//  Vitamin
//
//  Created by Jinhyang on 2021/08/06.
//

import UIKit

/* MARK: - TODO
 1. 폰트 적용
 2. 비밀번호 rule 추가
 */

class LoginViewController: UIViewController {

  @IBOutlet var commonTextField: CustomTextField!
  @IBOutlet var lookAroundButton: UIButton!
  @IBOutlet var continueButton: UIButton!
  @IBOutlet var emailTextFieldResginGestureRecognizer: UITapGestureRecognizer!
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var passwordTextField: CustomTextField!
  @IBOutlet var checkPasswordTextField: CustomTextField!
  @IBOutlet var continueButtonTopToEmailTextFieldConstraint: NSLayoutConstraint!
  @IBOutlet var passwordTextFieldTopToTitleLabelConstraint: NSLayoutConstraint!

  lazy var loginUser: LoginUser? = LoginUser(email: "", password: "")
  lazy var continueButtonTopToCheckPasswordTextFieldConstraint: NSLayoutConstraint = {
    return continueButton.topAnchor.constraint(equalTo: checkPasswordTextField.bottomAnchor, constant: 15)
  }()
  lazy var continueButtonTopToPasswordTextFieldConstrinat: NSLayoutConstraint = {
    return continueButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15)
  }()
  let textFieldValidColor: UIColor = .textBlack1
  let textFieldInvalidColor: UIColor = .textBlack5
  var viewType: ViewType?

  enum ViewType {
    case email
    case nickName
    case loginPassword
    case signUpPassword
    case findPassword

    var navigationTitle: String {
      switch self {
      case .email:
        return ""
      case .nickName:
        return "닉네임 설정"
      case .loginPassword:
        return "로그인"
      case .signUpPassword:
        return "회원가입"
      case .findPassword:
        return "비밀번호 찾기"
      }
    }

    var titleLabelText: String {
      switch self {
      case .email:
        return "반가워요.\n꿀꺽을 시작해볼까요?\n이메일을 부탁해요."
      case .nickName:
        return "꿀꺽이 고객님을\n어떻게 부르면 될까요?"
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

    setupNavigationBar()
    setupUI()
    setupObserver()
    updateViewByViewType()
  }

  func setupNavigationBar() {
    navigationController?.setNavigationBarHidden(false, animated: false)
    title = viewType?.navigationTitle

    guard let viewType = viewType,
          viewType != .email else { return }
    navigationItem.rightBarButtonItem =
      UIBarButtonItem(image: UIImage(named: "close"), style: .plain, target: self, action: #selector(close))
  }

  func setupUI() {
    continueButton.translatesAutoresizingMaskIntoConstraints = false
    continueButton.setTitleColor(UIColor.textBlack5, for: .disabled)
    continueButton.setTitleColor(UIColor.white, for: .normal)
    continueButton.makeRounded(radius: 13)
    commonTextField.setupUI()
    passwordTextField.setupUI()
    checkPasswordTextField.setupUI()
    updateContinueButton()
    lookAroundButton.addBottomBorder(color: UIColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1),
                                     borderWidth: 1,
                                     originYOffset: -3)
  }

  func setupObserver() {
    commonTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
    passwordTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
    checkPasswordTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

  }

  @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
    commonTextField.resignFirstResponder()
  }

  @IBAction func lookAround(_ sender: UIButton) {
    // MARK: TODO - Home으로 연결
  }

  @IBAction func tapContinueButton(_ sender: UIButton) {
    switch self.viewType {
    case .email:
      // MARK: TODO; 이메일 등록 여부 확인 후, signUp이나 login으로 넘어가기
      loginUser?.email = commonTextField.text
      checkEmail { exist in
        self.pushViewController(vcType: LoginViewController.self,
                           storyboardName: Constants.StoryboardName.SignUp.rawValue,
                           viewType: exist ? .loginPassword : .signUpPassword)
      }
    case .findPassword:
      // MARK: TODO ; 비밀번호 찾기 기능
      print(">")
    case .loginPassword:
      login { success in
        guard success,
              let currentUser = LoginManager.shared.currentUser else {
          // 에러 핸들링
          return
        }

        if let _ = currentUser.type {
          // MARK: HOME이동
        } else {
          // MARK: 온보딩 이동
        }
      }
    case .nickName:
      // MARK: TODO ; 회원가입 request 요청하고 Home으로 이동하기
      print(">")
    case .signUpPassword:
      loginUser?.password = commonTextField.text
      self.viewType = .nickName
      pushViewController(vcType: LoginViewController.self,
                         storyboardName: Constants.StoryboardName.SignUp.rawValue,
                         viewType: .nickName)
    default:
      break
    }
  }

  // MARK: 뷰 업데이트
  func updateContinueButton(isEnable: Bool? = nil) {
    if let isEnable = isEnable {
      continueButton.isEnabled = isEnable
    }

    continueButton.backgroundColor = continueButton.isEnabled ?
      .black :  UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1)
  }

  func updateViewByViewType() {
    commonTextField.text = ""
    commonTextField.isHidden = true
    passwordTextField.isHidden = true
    checkPasswordTextField.isHidden = true
    updateContinueButton(isEnable: false)
    continueButtonTopToEmailTextFieldConstraint.isActive = false

    switch viewType {
    case .email:
      commonTextField.isHidden = false
      continueButtonTopToEmailTextFieldConstraint.isActive = true
    case .signUpPassword:
      passwordTextField.isHidden = false
      checkPasswordTextField.isHidden = false
      continueButtonTopToCheckPasswordTextFieldConstraint.isActive = true
    case .nickName:
      commonTextField.isHidden = false
      continueButtonTopToEmailTextFieldConstraint.isActive = true
    case .loginPassword:
      passwordTextField.isHidden = false
      passwordTextFieldTopToTitleLabelConstraint.constant = 125
      continueButtonTopToPasswordTextFieldConstrinat.isActive = true
    default:
      break
    }

    titleLabel.text = viewType?.titleLabelText
  }

  func pushViewController<T: UIViewController>(vcType: T.Type, storyboardName: String, viewType: ViewType? = nil) {
    if vcType == LoginViewController.self {
      guard let nextVC = UIStoryboard(name: storyboardName, bundle: nil)
              .instantiateViewController(withIdentifier: LoginViewController.identifier) as? LoginViewController else {
        return
      }

      nextVC.viewType = viewType
      self.navigationController?.pushViewController(nextVC, animated: true)
      return
    }

    guard let nextVC = UIStoryboard(name: storyboardName, bundle: nil)
            .instantiateViewController(withIdentifier: vcType.identifier) as? LoginViewController else {
      return
    }

    self.navigationController?.pushViewController(nextVC, animated: true)
  }

  @objc func close() {
    switch self.viewType {
    case .loginPassword, .signUpPassword, .nickName:
      self.navigationController?.popToRootViewController(animated: true)
    default:
      break
    }
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
