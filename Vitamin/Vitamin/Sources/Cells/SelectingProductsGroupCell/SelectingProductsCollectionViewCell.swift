//
//  SelectingProductsCollectionViewCell.swift
//  Vitamin
//
//  Created by Jinhyang on 2021/08/15.
//

import UIKit

class SelectingProductsCollectionViewCell: UICollectionViewCell {

  @IBOutlet var titleLabel: UILabel!

  let selectedLabelColor = UIColor.black
  let selectedBackgroundColor = UIColor.white
  let deselectedLabelColor = UIColor.bg
  let deselectedBackgroundColor = UIColor.textBlack5

  override func awakeFromNib() {
    super.awakeFromNib()
    titleLabel.makeRounded(radius: 6)
    titleLabel.backgroundColor = deselectedBackgroundColor
    titleLabel.textColor = deselectedLabelColor
  }

  override var isSelected: Bool {
    didSet {
      if isSelected {
        titleLabel.backgroundColor = selectedBackgroundColor
        titleLabel.textColor = selectedLabelColor
        titleLabel.addBorder(color: .black, borderWidth: 1)
      } else {
        titleLabel.backgroundColor = deselectedBackgroundColor
        titleLabel.textColor = deselectedLabelColor
        titleLabel.addBorder(color: .clear, borderWidth: 1)
      }
    }
  }
}
