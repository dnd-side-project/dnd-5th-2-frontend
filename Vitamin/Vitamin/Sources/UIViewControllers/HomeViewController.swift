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

  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }

  func setupView() {
    let cornerRadius: CGFloat = 14
    firstProductsView.makeRounded(radius: cornerRadius)
    secondProductsView.makeRounded(radius: cornerRadius)
    thirdProductsView.makeRounded(radius: cornerRadius)
  }
}
