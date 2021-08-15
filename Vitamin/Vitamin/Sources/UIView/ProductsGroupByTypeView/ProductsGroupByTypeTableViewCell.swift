//
//  ProductsGroupByTypeTableViewCell.swift
//  Vitamin
//
//  Created by Jinhyang on 2021/08/13.
//

import UIKit

class ProductsGroupByTypeTableViewCell: UITableViewCell {

  @IBOutlet var productImageView: UIImageView!
  @IBOutlet var productNameLabel: UILabel!
  @IBOutlet var companyNameLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()

    productImageView.makeRounded(radius: 30)
    productImageView.applyCircleShadow(cornerRadius: productImageView.frame.height/2) // MARK: TODO 그림자 정보 확인하면 업데이트
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}
