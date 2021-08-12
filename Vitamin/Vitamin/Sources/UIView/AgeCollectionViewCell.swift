//
//  AgeCollectionViewCell.swift
//  Vitamin
//
//  Created by Jinhyang on 2021/08/12.
//

import UIKit

class AgeCollectionViewCell: UICollectionViewCell {

  @IBOutlet var titleLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()

    titleLabel.backgroundColor = UIColor.bg
    titleLabel.textColor = UIColor.textBlack5
  }

  override var isSelected: Bool {
    didSet {
      if isSelected {
        titleLabel.backgroundColor = UIColor.pink2
        titleLabel.textColor = UIColor.pink1
      } else {
        titleLabel.backgroundColor = UIColor.bg
        titleLabel.textColor = UIColor.textBlack5
      }
    }
  }

  func setup(radius: CGFloat) {
    titleLabel.makeRounded(radius: radius)
  }
}
