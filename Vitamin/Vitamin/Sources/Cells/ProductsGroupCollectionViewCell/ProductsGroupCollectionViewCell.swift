//
//  ProductsGroupCollectionViewCell.swift
//  Vitamin
//
//  Created by Jinhyang on 2021/08/18.
//

import UIKit

class ProductsGroupCollectionViewCell: UICollectionViewCell {

  @IBOutlet var horizontalProductsCollectionView: UICollectionView!

  override func awakeFromNib() {
    super.awakeFromNib()
    makeRounded(radius: 14)
    setupCollectionView()
  }

  func setupCollectionView() {
  }
}
