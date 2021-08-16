//
//  OnboardingResultViewController.swift
//  Vitamin
//
//  Created by 강인희 on 2021/08/11.
//

import Foundation
import UIKit

class OnboardingResultViewController: UIViewController {
  @IBOutlet weak var resultTableView: UITableView!
  @IBOutlet weak var resultHeaderView: UIView!
  @IBOutlet weak var resultFooterView: UIView!
  @IBOutlet weak var statusEmojiLabel: UILabel!
  @IBOutlet weak var resultDescriptionLabel: UILabel!
  @IBOutlet weak var detailDescriptionLabel: UILabel!
  @IBOutlet weak var endOnboardingButton: UIButton!

  let onboardingResult = OnboardingResult()
  private var personalResultText: ResultText?
  var personalTypeResult = Set<PersonalTypeCategory>()

  override func viewDidLoad() {
    self.navigationController?.navigationBar.isHidden = true

    switch personalTypeResult.count {
    case 0:
      personalResultText = onboardingResult.resultCases[.perfect]
    case 1...2:
      personalResultText = onboardingResult.resultCases[.good]
    case 3...4:
      personalResultText = onboardingResult.resultCases[.bad]
    default:
      personalResultText = onboardingResult.resultCases[.warning]
    }

    guard let personalResultText = self.personalResultText else {
      return
    }

    statusEmojiLabel.text = personalResultText.mainEmoji
    statusEmojiLabel.font = UIFont.Pretendard(type: .Regular, size: 56)

    resultDescriptionLabel.text = personalResultText.mainText
    resultDescriptionLabel.font = UIFont.Pretendard(type: .Medium, size: 25)

    detailDescriptionLabel.text = personalResultText.additionalText
    detailDescriptionLabel.font = UIFont.Pretendard(type: .Regular, size: 15)
    detailDescriptionLabel.textColor = UIColor(red: 73/255, green: 73/255, blue: 79/255, alpha: 1)

    endOnboardingButton.backgroundColor = .black
    endOnboardingButton.setTitleColor(.white, for: .normal)
    endOnboardingButton.setTitle("꿀꺽 시작하기", for: .normal)
    endOnboardingButton.makeRounded(radius: 13)
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    guard let headerView = resultHeaderView,
          let footerView = resultFooterView else {
      return
    }

    let headerHeight = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
    var headerFrame = headerView.frame

    if headerHeight != headerFrame.size.height {
      headerFrame.size.height = headerHeight
      headerView.frame = headerFrame
      resultTableView.tableHeaderView = headerView
    }

    let footerHeight = footerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
    var footerFrame = footerView.frame

    if footerHeight != footerFrame.size.height {
      footerFrame.size.height = footerHeight
      footerView.frame = footerFrame
      resultTableView.tableFooterView = footerView
    }
  }

  @IBAction func submitUserPersonalTypeResult(_ sender: Any) {
    let resultArray = personalTypeResult.map { personalTypeCategory -> String in
      switch personalTypeCategory {
      case .bone:
        return "관절/뼈 건강"
      case .eye:
        return "눈 건강"
      case .fatigue:
        return "피로"
      case .gut:
        return "장 건강"
      case .liver:
        return "간 건강"
      case .stomach:
        return "위 건강"
      }
    }

    LoginManager.shared.registerUserType(typeArray: resultArray) { <#Any?#> in
      <#code#>
    }
  }

}
extension OnboardingResultViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return onboardingResult.informationSet.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let healthInformationCell = tableView.dequeueReusableCell(withIdentifier: "HealthInformationCell", for: indexPath) as! HealthInformationCell

    if personalTypeResult.contains(onboardingResult.informationSet[indexPath.row].personalType) {
      healthInformationCell.updateUI(with: onboardingResult.informationSet[indexPath.row], true)
    } else {
      healthInformationCell.updateUI(with: onboardingResult.informationSet[indexPath.row], false)
    }

    return healthInformationCell
  }

}

struct HealthInformation {
  let introduction: String
  let title: String
  let personalType: PersonalTypeCategory
}

struct OnboardingResult {
  enum ResultType {
    case perfect
    case good
    case bad
    case warning
  }

  let resultCases: [ResultType: ResultText] = [
    .perfect: ResultText(mainEmoji: "👍🏻", mainText: "아주 잘하고 있어요", additionalText: "지금처럼만 관리한다면 무병장수 가능!"),
    .good: ResultText(mainEmoji: "⛵️", mainText: "건강 순항 중이에요", additionalText: "아쉬운 부분은 꿀꺽과 함께 채워볼까요?"),
    .bad: ResultText(mainEmoji: "👀", mainText: "주의가 필요해요", additionalText: "꿀꺽과 함께 더 건강해져봐요."),
    .warning: ResultText(mainEmoji: "🚨", mainText: "건강 적신호 ON", additionalText: "위험해요! 세심한 건강 관리가 시급해요.")
  ]

  let informationSet = [
    HealthInformation(introduction: "과도한 업무로 혹사당하는 눈", title: "눈 건강", personalType: .eye),
    HealthInformation(introduction: "삶의 질을 떨어뜨리는 장트러블", title: "장 건강", personalType: .gut),
    HealthInformation(introduction: "만성이 되면 개선이 어려운", title: "위 건강", personalType: .stomach),
    HealthInformation(introduction: "현대인의 필수 고충", title: "피로", personalType: .fatigue),
    HealthInformation(introduction: "과도한 음주로 혹사당하는 간", title: "간 건강", personalType: .liver),
    HealthInformation(introduction: "세심한 습관이 필요한 관절", title: "관절 / 뼈 건강", personalType: .bone)
  ]
}

struct ResultText {
  let mainEmoji: String
  let mainText: String
  let additionalText: String
}
