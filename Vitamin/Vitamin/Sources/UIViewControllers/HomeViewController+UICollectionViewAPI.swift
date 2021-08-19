//
//  HomeViewController+UICollectionViewAPI.swift
//  Vitamin
//
//  Created by Jinhyang on 2021/08/15.
//

import UIKit

extension HomeViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 3
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsGroupCollectionViewCell.identifier, for: indexPath) as? ProductsGroupCollectionViewCell else {
      return UICollectionViewCell()
    }

    return cell
  }

  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                           withReuseIdentifier: ProductsGroupCollectionReusableView.identifier,
                                                                           for: indexPath) as? ProductsGroupCollectionReusableView else { return
                                                                            UICollectionReusableView() }

    if let user = user {
      headerView.titleLabel.text = "\(user.username ?? "")님 \n오늘도 꿀-꺽 해볼까요?"
      headerView.setupViewForLoginUser()
    }

    return headerView
  }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width - collectionViewCellEdgeInsets.left * 2, height: 414)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    let height: CGFloat = user == nil ? 240 : 146
    return CGSize(width: collectionView.frame.width, height: height)
  }
}
