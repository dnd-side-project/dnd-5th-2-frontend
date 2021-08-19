//
//  ProductsGroupCollectionReusableView.swift
//  Vitamin
//
//  Created by Jinhyang on 2021/08/19.
//

import UIKit

class ProductsGroupCollectionReusableView: UICollectionReusableView {

  var showLoginViewDelegate: (() -> Void)?

  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var loginGuideView: UIView!
  @IBOutlet var loginButton: UIButton!
  @IBOutlet var loginGuideViewBottomConstraint: NSLayoutConstraint!

  override func awakeFromNib() {
    super.awakeFromNib()
    loginGuideView.makeRounded(radius: 14)
    loginButton.makeRounded(radius: loginButton.frame.height/2)
  }

  @IBAction func tapLogin(_ sender: UIButton) {
    showLoginViewDelegate?()
  }

  func setupViewForLoginUser() {
    loginGuideView.isHidden = true
    loginGuideViewBottomConstraint.constant = 0
  }
}
