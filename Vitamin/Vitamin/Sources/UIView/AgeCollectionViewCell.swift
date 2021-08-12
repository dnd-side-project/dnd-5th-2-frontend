//
//  AgeCollectionViewCell.swift
//  Vitamin
//
//  Created by Jinhyang on 2021/08/12.
//

import UIKit

class AgeCollectionViewCell: UICollectionViewCell {

  @IBOutlet var circleView: UIView!
  @IBOutlet var titleLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()

    circleView.makeRounded(radius: circleView.frame.height/2)
    titleLabel.backgroundColor = UIColor.textBlack5
    titleLabel.textColor = UIColor.bg
  }

  override var isSelected: Bool {
    didSet {
      if isSelected {
        circleView.backgroundColor = UIColor.pink2
        titleLabel.textColor = UIColor.pink1
      } else {
        circleView.backgroundColor = UIColor.bg
        titleLabel.textColor = UIColor.textBlack5
      }
    }
  }
}
