//
//  ProductsGroupByUserView.swift
//  Vitamin
//
//  Created by Jinhyang on 2021/08/14.
//

import UIKit

class ProductsGroupByUserView: UIView {

  @IBOutlet var productsCollectionView: UICollectionView!
  @IBOutlet var selectingProductsGroupCollectionView: UICollectionView!

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
    let selectingCell = UINib(nibName: SelectingProductsCollectionViewCell.identifier, bundle: nil)
    productsCollectionView.register(cell, forCellWithReuseIdentifier: ProductsGroupByUserCollectionViewCell.identifier)
    selectingProductsGroupCollectionView.register(selectingCell, forCellWithReuseIdentifier: SelectingProductsCollectionViewCell.identifier)
    selectingProductsGroupCollectionView.selectItem(at: IndexPath(row: 0, section: 0),
                                                    animated: false,
                                                    scrollPosition: .centeredVertically)
  }
}

extension ProductsGroupByUserView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if collectionView == productsCollectionView {
      return 6
    } else {
      return 3
    }
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if collectionView == productsCollectionView,
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsGroupByUserCollectionViewCell.identifier, for: indexPath) as? ProductsGroupByUserCollectionViewCell {
      return cell
    }

    if collectionView == selectingProductsGroupCollectionView,
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectingProductsCollectionViewCell.identifier, for: indexPath) as? SelectingProductsCollectionViewCell {
      return cell
    }

    return UICollectionViewCell()
  }
}

extension ProductsGroupByUserView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    if collectionView == productsCollectionView {
      let width = (collectionView.frame.width - collectionViewPadding * CGFloat(itemsCountPerRow + 1)) / CGFloat(itemsCountPerRow)
      return CGSize(width: width, height: width * 138 / 97)
    }

    if collectionView == selectingProductsGroupCollectionView {
      return CGSize(width: 88, height: 24)
    }

    return .zero
  }
}
