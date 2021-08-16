//
//  HomeViewController.swift
//  Vitamin
//
//  Created by Jinhyang on 2021/08/13.
//

import UIKit

class HomeViewController: UIViewController {

  @IBOutlet var firstProductsView: ProductsGroupByTypeView!
  @IBOutlet var secondProductsView: ProductsGroupByUserView!
  @IBOutlet var thirdProductsView: ProductsGroupByTypeView!
  @IBOutlet var typeTagCollectionView: UICollectionView!

  override func viewDidLoad() {
    super.viewDidLoad()
    setupStyle()
  }

  func setupStyle() {
    let cornerRadius: CGFloat = 14
    firstProductsView.makeRounded(radius: cornerRadius)
    secondProductsView.makeRounded(radius: cornerRadius)
    thirdProductsView.makeRounded(radius: cornerRadius)
    typeTagCollectionView.contentInset = UIEdgeInsets(top: .zero, left: 20, bottom: .zero, right: 20)
  }
}
