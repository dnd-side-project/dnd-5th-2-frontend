//
//  HomeViewController.swift
//  Vitamin
//
//  Created by Jinhyang on 2021/08/13.
//

import UIKit

class HomeViewController: UIViewController {

  @IBOutlet var welcomeLabel: UILabel!
  @IBOutlet var firstProductsView: ProductsGroupByTypeView!
  @IBOutlet var secondProductsView: ProductsGroupByUserView!
  @IBOutlet var thirdProductsView: ProductsGroupByTypeView!
  @IBOutlet var typeTagCollectionView: UICollectionView!

  let user = LoginManager.shared.currentUser

  override func viewDidLoad() {
    super.viewDidLoad()
    loadUserInformation()
    setupStyle()
  }

  func setupStyle() {
    let cornerRadius: CGFloat = 14
    firstProductsView.makeRounded(radius: cornerRadius)
    secondProductsView.makeRounded(radius: cornerRadius)
    thirdProductsView.makeRounded(radius: cornerRadius)
    typeTagCollectionView.contentInset = UIEdgeInsets(top: .zero, left: 20, bottom: .zero, right: 20)
  }

  func loadUserInformation() {
    guard let user = user else {
      welcomeLabel.text = "어서오세요"
      return
    }

    welcomeLabel.text = "\(user.username ?? "")님, 어서오세요"
  }
}
