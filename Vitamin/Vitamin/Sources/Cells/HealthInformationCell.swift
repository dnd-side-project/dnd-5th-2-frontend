//
//  HealthInformationCell.swift
//  Vitamin
//
//  Created by 강인희 on 2021/08/13.
//

import Foundation
import UIKit

class HealthInformationCell: UITableViewCell {
  @IBOutlet weak var informationView: UIView!
  @IBOutlet weak var introductionLabel: UILabel!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var statusLabel: UIButton!

  func updateUI(with healthInformation: HealthInformation) {
    informationView.makeRounded(radius: 14)

    introductionLabel.text = healthInformation.introduction
    introductionLabel.font = UIFont.Pretendard(type: .Regular, size: 13)
    introductionLabel.textColor = UIColor(red: 115/255, green: 115/255, blue: 124/255, alpha: 1)

    titleLabel.text = healthInformation.title
    titleLabel.font = UIFont.Pretendard(type: .Medium, size: 15)

    statusLabel.setTitle(healthInformation.status, for: .normal)
  }
}
