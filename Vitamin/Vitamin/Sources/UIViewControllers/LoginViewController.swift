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
  @IBOutlet var guideLabelBottomToContinueButtonConstraint: NSLayoutConstraint!
  @IBOutlet var selectingGenderAgeView: SelectingGenderAgeView!
  @IBOutlet var guideLabel: UILabel!

  lazy var continueButtonTopToCheckPasswordTextFieldConstraint: NSLayoutConstraint = {
    return continueButton.topAnchor.constraint(equalTo: checkPasswordTextField.bottomAnchor, constant: 37)
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

    var defaultGuideLabel: String {
      switch self {
      case .signUpPassword:
        return  "6~12자 까지 작성해주세요."
      case .nickName:
        return "2~7자 까지 작성해주세요."
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
    guideLabel.text = viewType?.defaultGuideLabel

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
    pushViewController(vcType: HomeViewController.self,
                       storyboardName: .Home)
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
                                storyboardName: .SignUp,
                                viewType: exist ? .loginPassword : .signUpPassword)
      }
    case .findPassword:
      // MARK: TODO ; 비밀번호 찾기 기능
      print(">")
    case .loginPassword:
      user?.password = passwordTextField.text

      login { [weak self] success in
        guard success,
              let currentUser = LoginManager.shared.currentUser else {
          self?.guideLabel.text = "비밀번호를 틀렸네요. \n다시 확인해주세요."
          self?.updateContinueButton(isEnable: false)
          return
        }

        if !currentUser.types.isEmpty {
          self?.pushViewController(vcType: HomeViewController.self, storyboardName: .Home)
        } else {
          self?.pushViewController(vcType: OnboardingViewController.self, storyboardName: .Onboarding)
        }
      }
    case .signUpPassword:
      user?.password = passwordTextField.text
      pushViewController(vcType: LoginViewController.self,
                         storyboardName: .SignUp,
                         viewType: .nickName)
    case .nickName:
      guard let userName = commonTextField.text,
            !userName.isEmpty else { return }
      user?.username = userName
      checkNickName(nickName: userName) { [weak self] exists in
        guard !exists else {
          self?.guideLabel.text = "이미 존재하는 닉네임입니다."
          self?.commonTextField.shouldBeEdited = true
          return
        }

        self?.pushViewController(vcType: LoginViewController.self,
                           storyboardName: .SignUp,
                           viewType: .setGenderAge)
      }
    case .setGenderAge:
      signUp { [weak self] success in
        guard let self = self else { return }
        guard success,
              let currentUser = LoginManager.shared.currentUser else {
          self.pushViewController(vcType: LoginFailureViewController.self, storyboardName: .SignUp)
          return
        }

        if !currentUser.types.isEmpty {
          self.pushViewController(vcType: HomeViewController.self, storyboardName: .Home)
        } else {
          self.pushViewController(vcType: OnboardingViewController.self, storyboardName: .Onboarding)
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
    guideLabel.isHidden = true
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
      guideLabelBottomToContinueButtonConstraint.constant = -12
      guideLabel.text = viewType?.defaultGuideLabel
      guideLabel.isHidden = false
    case .nickName:
      commonTextField.isHidden = false
      continueButtonTopToEmailTextFieldConstraint.constant = 51
      continueButtonTopToEmailTextFieldConstraint.isActive = true
      guideLabelBottomToContinueButtonConstraint.constant = -22
      guideLabel.text = viewType?.defaultGuideLabel
      guideLabel.isHidden = false
    case .loginPassword:
      passwordTextField.isHidden = false
      passwordTextFieldTopToTitleLabelConstraint.constant = 125
      continueButtonTopToPasswordTextFieldConstraint.isActive = true
    case .setGenderAge:
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

  func pushViewController<T: UIViewController>(vcType: T.Type, storyboardName: Constants.StoryboardName, viewType: ViewType? = nil) {
    let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)

    guard vcType == LoginViewController.self,
          let nextVC = storyboard.instantiateViewController(withIdentifier: LoginViewController.identifier) as? LoginViewController else {
      if let nextVC = storyboard.instantiateViewController(withIdentifier: vcType.identifier) as? T {
        self.navigationController?.pushViewController(nextVC, animated: true)
      }
      return
    }

    nextVC.viewType = viewType
    nextVC.user = user
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
