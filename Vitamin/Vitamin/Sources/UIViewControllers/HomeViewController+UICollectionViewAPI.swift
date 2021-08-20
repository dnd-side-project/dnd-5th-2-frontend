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

    cell.titleLabel.text = PersonalTypeCategory.allCases[indexPath.row].homeTitle
    cell.subtitleLabel.text = PersonalTypeCategory.allCases[indexPath.row].homeSubtitle

    if indexPath.row == 0 {
      cell.supplements = [Supplement(supplementName: "진센큐", companyName: "바른영양연구소"),
                          Supplement(supplementName: "위건강엔 매스틱", companyName: "(주)코스맥스 바이오"),
                          Supplement(supplementName: "나우푸드", companyName: "now")]
    } else {
      cell.supplements = [Supplement(supplementName: "프로바이오틱스", companyName: "나우제약"),
                          Supplement(supplementName: "구미젤리", companyName: "네이쳐스웨이"),
                          Supplement(supplementName: "베지캡술", companyName: "닥터스베스트")]
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
