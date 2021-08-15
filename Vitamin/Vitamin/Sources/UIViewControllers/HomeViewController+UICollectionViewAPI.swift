//
//  HomeViewController+UICollectionViewAPI.swift
//  Vitamin
//
//  Created by Jinhyang on 2021/08/15.
//

import UIKit

class TypeTagCollectionViewCell: UICollectionViewCell {
  @IBOutlet var typeNameLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()

    typeNameLabel.makeRounded(radius: contentView.frame.height/2)
    typeNameLabel.addBorder(color: UIColor(red: 232/255, green: 232/255, blue: 238/255, alpha: 1), borderWidth: 1)
  }
}

extension HomeViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 3
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TypeTagCollectionViewCell.identifier, for: indexPath) as? TypeTagCollectionViewCell else {
      return UICollectionViewCell()
    }

    return cell
  }
}
