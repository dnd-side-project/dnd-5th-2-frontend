//
//  ProductsGroupByTypeView.swift
//  Vitamin
//
//  Created by Jinhyang on 2021/08/13.
//

import UIKit

class ProductsGroupByTypeView: UIView {

  @IBOutlet var tableView: UITableView!

  let tableViewItemCount = 3

  override init(frame: CGRect) {
      super.init(frame: frame)
      commonInit()
  }

  required public init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      commonInit()
  }

  func commonInit() {
    guard let view = Bundle.main.loadNibNamed(ProductsGroupByTypeView.identifier, owner: self, options: nil)?
            .first as? UIView else { return }
    view.frame = self.bounds
    self.addSubview(view)

    setupTableView()
  }

  func setupTableView() {
    let cell = UINib(nibName: ProductsGroupByTypeTableViewCell.identifier, bundle: nil)
    tableView.register(cell, forCellReuseIdentifier: ProductsGroupByTypeTableViewCell.identifier)
  }
}

extension ProductsGroupByTypeView: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tableViewItemCount
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductsGroupByTypeTableViewCell.identifier) as? ProductsGroupByTypeTableViewCell else {
      return UITableViewCell()
    }

    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return tableView.frame.height / CGFloat(tableViewItemCount)
  }
}
