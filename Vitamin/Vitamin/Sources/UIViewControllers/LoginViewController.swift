//
//  LoginViewController.swift
//  Vitamin
//
//  Created by Jinhyang on 2021/08/06.
//

import UIKit

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
  @IBOutlet var selectingGenderAgeView: SelectingGenderAgeView!

  lazy var continueButtonTopToCheckPasswordTextFieldConstraint: NSLayoutConstraint = {
    return continueButton.topAnchor.constraint(equalTo: checkPasswordTextField.bottomAnchor, constant: 15)
  }()
  lazy var continueButtonTopToPasswordTextFieldConstraint: NSLayoutConstraint = {
    return continueButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15)
  }()
  lazy var continueButtonBottomToSafeAreaConstraint: NSLayoutConstraint = {
    return continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -48)
  }()
  let textFieldValidColor: UIColor = .textBlack1
  let textFieldInvalidColor: UIColor = .textBlack5
  var viewType: ViewType?
  var user: User?

  enum ViewType {
    case email
    case nickName
    case loginPassword
    case signUpPassword
    case findPassword
    case setGenderAge

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
      case .setGenderAge:
        return "성별 및 나이 설정"
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
      case .setGenderAge:
        return "마지막으로 성별과 \n연령 정보가 필요해요."
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

  override func viewWillDisappear(_ animated: Bool) {
    commonTextField.text = ""
    passwordTextField.text = ""
    checkPasswordTextField.text = ""

    if commonTextField.isFirstResponder {
      commonTextField.resignFirstResponder()
    } else if passwordTextField.isFirstResponder {
      passwordTextField.resignFirstResponder()
    } else if checkPasswordTextField.isFirstResponder {
      checkPasswordTextField.resignFirstResponder()
    }

    updateContinueButton(isEnable: false)
  }

  func setupNavigationBar() {
    navigationItem.backButtonTitle = ""
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
    if user == nil {
      user = User()
    }

    switch self.viewType {
    case .email:
      guard let email = commonTextField.text else {
        return
      }
      user?.email = email
      checkEmail(email: email) { exist in
        self.pushViewController(vcType: LoginViewController.self,
                                storyboardName: Constants.StoryboardName.SignUp.rawValue,
                                viewType: exist ? .loginPassword : .signUpPassword)
      }
    case .findPassword:
      // MARK: TODO ; 비밀번호 찾기 기능
      print(">")
    case .loginPassword:
      user?.password = passwordTextField.text

      login { success in
        guard success,
              let currentUser = LoginManager.shared.currentUser else {
          // 에러 핸들링
          return
        }

        if let _ = currentUser.type {
          // MARK: HOME이동
        } else {
          self.pushViewController(vcType: OnboardingViewController.self, storyboardName: Constants.StoryboardName.Onboarding.rawValue)
        }
      }
    case .signUpPassword:
      user?.password = passwordTextField.text
      pushViewController(vcType: LoginViewController.self,
                         storyboardName: Constants.StoryboardName.SignUp.rawValue,
                         viewType: .nickName)
    case .nickName:
      guard let userName = commonTextField.text,
            !userName.isEmpty else { return }
      user?.username = userName
      checkNickName(nickName: userName) { [weak self] exists in
        guard !exists else {
          // TODO: 닉네임 존재할 때 핸들링
          return
        }

        self?.pushViewController(vcType: LoginViewController.self,
                           storyboardName: Constants.StoryboardName.SignUp.rawValue,
                           viewType: .setGenderAge)
      }
    case .setGenderAge:
      signUp { success in
        guard success,
              let currentUser = LoginManager.shared.currentUser else {
          // 에러 핸들링
          return
        }

        if let _ = currentUser.type {
          // MARK: HOME이동
        } else {
          self.pushViewController(vcType: OnboardingViewController.self, storyboardName: Constants.StoryboardName.Onboarding.rawValue)
        }
      }
      break
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
    lookAroundButton.isHidden = true
    updateContinueButton(isEnable: false)
    continueButtonTopToEmailTextFieldConstraint.isActive = false
    continueButtonBottomToSafeAreaConstraint.isActive = false

    switch viewType {
    case .email:
      lookAroundButton.isHidden = false
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
      continueButtonTopToPasswordTextFieldConstraint.isActive = true
    case .setGenderAge:
      continueButtonTopToEmailTextFieldConstraint.isActive = false
      emailTextFieldResginGestureRecognizer.isEnabled = false
      continueButtonBottomToSafeAreaConstraint.isActive = true
      selectingGenderAgeView.isHidden = false
      selectingGenderAgeView.selectedValues = { [weak self] gender, age in
        self?.user?.gender = gender
        self?.user?.age = age
        self?.updateContinueButton(isEnable: true)
      }
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
      nextVC.user = user
      self.navigationController?.pushViewController(nextVC, animated: true)
      return
    }

    guard let nextVC = UIStoryboard(name: storyboardName, bundle: nil)
            .instantiateViewController(withIdentifier: vcType.identifier) as? T else {
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
