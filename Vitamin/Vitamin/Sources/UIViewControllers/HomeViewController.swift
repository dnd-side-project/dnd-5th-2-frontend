//
//  HomeViewController.swift
//  Vitamin
//
//  Created by Jinhyang on 2021/08/13.
//

import UIKit

class HomeViewController: UIViewController {

  @IBOutlet var collectionView: UICollectionView!

  let user = LoginManager.shared.currentUser

  let collectionViewCellEdgeInsets = UIEdgeInsets(top: .zero, left: 20, bottom: 16, right: 20)

  override func viewDidLoad() {
    super.viewDidLoad()
    setupStyle()
    registerCollectionView()
  }

  func setupStyle() {

  }

  func registerCollectionView() {
    let cell = UINib(nibName: ProductsGroupCollectionViewCell.identifier, bundle: nil)
    let headerView = UINib(nibName: ProductsGroupCollectionReusableView.identifier, bundle: nil)
    collectionView.register(cell, forCellWithReuseIdentifier: ProductsGroupCollectionViewCell.identifier)
    collectionView.register(headerView, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: ProductsGroupCollectionReusableView.identifier)
  }
}
