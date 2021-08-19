//
//  OnboardingViewController.swift
//  Vitamin
//
//  Created by 강인희 on 2021/08/07.
//

import UIKit

class OnboardingViewController: UIViewController {
  @IBOutlet weak var mainIntroductionLabel: UILabel!
  @IBOutlet weak var subIntroductionLabel: UILabel!
  @IBOutlet weak var checkUpButton: UIButton!
  @IBOutlet weak var skipButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()

    updateRootViewController()
    setMainIntroductionLabel()
    setSubIntroductionLabel()
    setCheckUpButton()
    setSkipButton()
  }

  @IBAction func pushHomeVC(_ sender: UIButton) {
    self.navigationController?.changeRootViewController(vcType: HomeViewController.self,
                                                        storyboardName: .Home)
  }

  func updateRootViewController() {
    if let filterdViewControllers = self.navigationController?.viewControllers.filter({ $0 is OnboardingViewController }) {
      self.navigationController?.viewControllers = filterdViewControllers
    }
  }

  private func setMainIntroductionLabel() {
    mainIntroductionLabel.text = "어떤 영양제가 필요한지\n꿀꺽이 알려드릴게요."
    mainIntroductionLabel.numberOfLines = 2
    mainIntroductionLabel.font = UIFont.Pretendard(type: .Medium, size: 23)
  }

  private func setSubIntroductionLabel() {
    subIntroductionLabel.text = "시작하기 전, 간단한 질문을 통해, 딱 맞는\n영양제를 분석하여 큐레이션 해드릴게요."
    subIntroductionLabel.numberOfLines = 2
    subIntroductionLabel.textColor = UIColor(red: 115/255, green: 115/255, blue: 124/255, alpha: 1)
    subIntroductionLabel.font = UIFont.Pretendard(type: .Light, size: 15)
  }

  private func setCheckUpButton() {
    checkUpButton.backgroundColor = .black
    checkUpButton.setTitleColor(.white, for: .normal)
    checkUpButton.setTitle("건강 유형 검사하기", for: .normal)
    checkUpButton.makeRounded(radius: 13)
  }

  private func setSkipButton() {
    skipButton.setTitleColor(UIColor(red: 115/255, green: 115/255, blue: 124/255, alpha: 1), for: .normal)

    let skipText = "다음에 하기"
    let titleString = NSMutableAttributedString(string: skipText)
    titleString.addAttribute(NSAttributedString.Key.underlineStyle,
                             value: NSUnderlineStyle.single.rawValue,
                             range: NSRange(location: 0, length: skipText.count))
    skipButton.setAttributedTitle(titleString, for: .normal)
  }
}
