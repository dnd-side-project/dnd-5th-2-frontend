//
//  OnboardingResultViewController.swift
//  Vitamin
//
//  Created by 강인희 on 2021/08/11.
//

import Foundation
import UIKit

class OnboardingResultViewController: UIViewController {
  @IBOutlet weak var statusEmojiLabel: UILabel!
  @IBOutlet weak var resultDescriptionLabel: UILabel!
  @IBOutlet weak var detailDescriptionLabel: UILabel!

  override func viewDidLoad() {
    statusEmojiLabel.text = "👍"
    resultDescriptionLabel.text = "아주 잘하고 있어요"
    detailDescriptionLabel.text = "지금처럼만 관리한다면 무병장수 가능!"
  }

}
