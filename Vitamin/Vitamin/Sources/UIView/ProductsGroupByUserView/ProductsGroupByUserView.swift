//
//  ProductsGroupByUserView.swift
//  Vitamin
//
//  Created by Jinhyang on 2021/08/14.
//

import UIKit

class ProductsGroupByUserView: UIView {

  @IBOutlet var collectionView: UICollectionView!

  let itemsCountPerRow = 3
  let collectionViewPadding: CGFloat = 7

  override init(frame: CGRect) {
      super.init(frame: frame)
      commonInit()
  }

  required public init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      commonInit()
  }

  func commonInit() {
    guard let view = Bundle.main.loadNibNamed(ProductsGroupByUserView.identifier, owner: self, options: nil)?
            .first as? UIView else { return }
    view.frame = self.bounds
    self.addSubview(view)

    setupTableView()
  }

  func setupTableView() {
    let cell = UINib(nibName: ProductsGroupByUserCollectionViewCell.identifier, bundle: nil)
    collectionView.register(cell, forCellWithReuseIdentifier: ProductsGroupByUserCollectionViewCell.identifier)
  }
}

extension ProductsGroupByUserView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 6
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsGroupByUserCollectionViewCell.identifier, for: indexPath) as? ProductsGroupByUserCollectionViewCell else {
      return UICollectionViewCell()
    }
    
    return cell
  }
}

extension ProductsGroupByUserView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = (collectionView.frame.width - collectionViewPadding * CGFloat(itemsCountPerRow + 1)) / CGFloat(itemsCountPerRow)
    return CGSize(width: width, height: width * 138 / 97)
  }
}
