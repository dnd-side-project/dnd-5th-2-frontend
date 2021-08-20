//
//  ProductsGroupCollectionViewCell+Extension.swift
//  Vitamin
//
//  Created by Jinhyang on 2021/08/20.
//

import UIKit

extension ProductsGroupCollectionViewCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 3
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThreeProductsCollectionViewCell.identifier,
                                                        for: indexPath) as? ThreeProductsCollectionViewCell
    else { return UICollectionViewCell() }
    cell.supplements = supplements
    return cell
  }
}

extension ProductsGroupCollectionViewCell: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return collectionView.frame.size
  }
}

extension ProductsGroupCollectionViewCell: UICollectionViewDelegate { }
