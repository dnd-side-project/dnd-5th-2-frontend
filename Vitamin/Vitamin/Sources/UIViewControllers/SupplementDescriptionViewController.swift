//
//  SupplementDescriptionViewController.swift
//  Vitamin
//
//  Created by 강인희 on 2021/08/17.
//

import UIKit

class SupplementDescriptionViewController: UIViewController {
  @IBOutlet var navigationButtons: [UIButton]!

  @IBOutlet weak var imageScrollView: UIScrollView!
  @IBOutlet weak var imagesStackView: UIStackView!
  @IBOutlet weak var defaultImageView: UIImageView!
  @IBOutlet weak var imagePageControl: UIPageControl!
  @IBOutlet weak var supplementNameLabel: UILabel!
  @IBOutlet weak var supplementCompanyLabel: UILabel!

  @IBOutlet weak var ingredientInformationLabel: UILabel!
  @IBOutlet weak var ingredientInformationLabel2: UILabel!
  @IBOutlet weak var supplementIngredientLabel: UILabel!

  @IBOutlet weak var effectInformationLabel: UILabel!
  @IBOutlet weak var supplementEffectLabel: UILabel!

  @IBOutlet weak var noticeInformationLabel: UILabel!
  @IBOutlet weak var supplementNoticeLabel: UILabel!

  var imageViews = [UIImageView]()
  var images: [UIImage] = [#imageLiteral(resourceName: "close"), #imageLiteral(resourceName: "backButton"), #imageLiteral(resourceName: "loginLogo"), #imageLiteral(resourceName: "loginLogo")]

  override func viewDidLoad() {
    super.viewDidLoad()
    imageScrollView.delegate = self
    setNavigationButtons()
    setPageControl()
    setImagesStackView()
    setSupplementInformationLabels()
    setSupplementDetailDescriptionLabels()
  }

  private func setNavigationButtons() {
    for button in navigationButtons {
      button.imageView?.contentMode = .scaleAspectFit
      button.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
  }
  private func setImagesStackView() {
    guard images.count > 0 else {
      return
    }

    defaultImageView.image = images.first

    for imageIndex in 1 ..< images.count {
     let imageView = UIImageView()
      imageView.frame = CGRect(x: 0, y: 0, width: imageScrollView.frameLayoutGuide.layoutFrame.width, height: 200)
      imageView.image = images[imageIndex]
      imageView.contentMode = .scaleAspectFit
      imagesStackView.addArrangedSubview(imageView)
    }
  }

  private func setSupplementInformationLabels() {
    supplementNameLabel.text = "베지캡슐 다이제스티브"
    supplementCompanyLabel.text = "닥터스베스트"
    supplementNameLabel.font = UIFont.Pretendard(type: .Semibold, size: 20)
    supplementCompanyLabel.font = UIFont.Pretendard(type: .Medium, size: 15)
    supplementCompanyLabel.textColor = UIColor(red: 73/255, green: 73/255, blue: 79/255, alpha: 1)
  }

  private func setSupplementDetailDescriptionLabels() {
    ingredientInformationLabel.text = "성분 및 함량"
    ingredientInformationLabel.font = UIFont.Pretendard(type: .Semibold, size: 20)

    ingredientInformationLabel2.text = "제품 성분"
    ingredientInformationLabel2.font = UIFont.Pretendard(type: .Medium, size: 15)

    supplementIngredientLabel.text = "지용성 비타민 A, E, D, K"
    supplementIngredientLabel.font = UIFont.Pretendard(type: .Regular, size: 15)

    effectInformationLabel.text = "효과 & 효능"
    effectInformationLabel.font = UIFont.Pretendard(type: .Semibold, size: 20)

    supplementEffectLabel.text = "피부 속 진피층에서 체내 수분을 저장하는 히알루론산의 보충으로 피부 보습에 도움을 줄 수 있습니다."
    supplementEffectLabel.font = UIFont.Pretendard(type: .Regular, size: 15)

    noticeInformationLabel.text = "부작용 & 주의 사항"
    noticeInformationLabel.font = UIFont.Pretendard(type: .Semibold, size: 20)

    supplementNoticeLabel.text = "피부 속 진피층에서 체내 수분을 저장하는 히알루론산의 보충으로 피부 보습에 도움을 줄 수 있습니다."
    supplementNoticeLabel.font = UIFont.Pretendard(type: .Regular, size: 15)
  }

  private func setPageControl() {
    imagePageControl.numberOfPages = images.count
  }

  private func setPageControlSelectedPage(currentPage: Int) {
    imagePageControl.currentPage = currentPage
  }
}
extension SupplementDescriptionViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let value = scrollView.contentOffset.x/scrollView.frame.size.width
    setPageControlSelectedPage(currentPage: Int(round(value)))
  }
}
