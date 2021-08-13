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

  override func viewDidLoad() {
    self.navigationController?.navigationBar.isHidden = true
    statusEmojiLabel.text = "👍🏻"
    statusEmojiLabel.font = UIFont.Pretendard(type: .Regular, size: 56)

    resultDescriptionLabel.text = "아주 잘하고 있어요"
    resultDescriptionLabel.font = UIFont.Pretendard(type: .Medium, size: 25)

    detailDescriptionLabel.text = "지금처럼만 관리한다면 무병장수 가능!"
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
}
extension OnboardingResultViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return onboardingResult.informationSet.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let healthInformationCell = tableView.dequeueReusableCell(withIdentifier: "HealthInformationCell", for: indexPath) as! HealthInformationCell

    healthInformationCell.updateUI(with: onboardingResult.informationSet[indexPath.row])

    return healthInformationCell
  }

}

struct HealthInformation {
  let introduction: String
  let title: String
  let personalType: PersonalTypeCategory
  let status: String
}

struct OnboardingResult {
  let informationSet = [
    HealthInformation(introduction: "과도한 업무로 혹사당하는 눈", title: "눈 건강", personalType: .eye, status: "양호"),
    HealthInformation(introduction: "삶의 질을 떨어뜨리는 장트러블", title: "장 건강", personalType: .gut, status: "양호"),
    HealthInformation(introduction: "만성이 되면 개선이 어려운", title: "위 건강", personalType: .stomach, status: "양호"),
    HealthInformation(introduction: "현대인의 필수 고충", title: "피로", personalType: .fatigue, status: "양호"),
    HealthInformation(introduction: "과도한 음주로 혹사당하는 간", title: "간 건강", personalType: .liver, status: "양호"),
    HealthInformation(introduction: "세심한 습관이 필요한 관절", title: "관절 / 뼈 건강", personalType: .bone, status: "양호")
  ]
}
