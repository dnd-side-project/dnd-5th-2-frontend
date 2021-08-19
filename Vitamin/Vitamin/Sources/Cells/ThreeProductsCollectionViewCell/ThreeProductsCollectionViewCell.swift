//
//  ThreeProductsCollectionViewCell.swift
//  Vitamin
//
//  Created by Jinhyang on 2021/08/18.
//

import UIKit

class ThreeProductsCollectionViewCell: UICollectionViewCell {

  @IBOutlet var tableView: UITableView!

  let tableViewItemCount = 3

  override func awakeFromNib() {
    super.awakeFromNib()
    setupTableView()
  }

  func setupTableView() {
    tableView.delegate = self
    tableView.dataSource = self

    let cell = UINib(nibName: ProductsGroupByTypeTableViewCell.identifier, bundle: nil)
    tableView.register(cell, forCellReuseIdentifier: ProductsGroupByTypeTableViewCell.identifier)
  }
}

extension ThreeProductsCollectionViewCell: UITableViewDataSource, UITableViewDelegate {
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
