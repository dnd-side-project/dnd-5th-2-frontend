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
    productImageView.addBorder(color: UIColor(red: 0.91, green: 0.91, blue: 0.93, alpha: 1), borderWidth: 1)
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}
