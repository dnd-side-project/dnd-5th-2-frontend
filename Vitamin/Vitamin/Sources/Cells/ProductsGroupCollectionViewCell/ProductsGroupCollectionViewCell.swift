//
//  ProductsGroupCollectionViewCell.swift
//  Vitamin
//
//  Created by Jinhyang on 2021/08/18.
//

import UIKit

class ProductsGroupCollectionViewCell: UICollectionViewCell {

  @IBOutlet var horizontalProductsCollectionView: UICollectionView!
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var subtitleLabel: UILabel!

  var supplements: [Supplement] = [] {
    didSet {
      horizontalProductsCollectionView.reloadData()
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    makeRounded(radius: 14)
    setupCollectionView()
  }

  func setupCollectionView() {
    horizontalProductsCollectionView.delegate = self
    horizontalProductsCollectionView.dataSource = self

    let cell = UINib(nibName: ThreeProductsCollectionViewCell.identifier, bundle: nil)
    horizontalProductsCollectionView.register(cell, forCellWithReuseIdentifier: ThreeProductsCollectionViewCell.identifier)
  }
}