//
//  SelectingGenderAgeView.swift
//  Vitamin
//
//  Created by Jinhyang on 2021/08/12.
//

import UIKit

class SelectingGenderAgeView: UIView {

  @IBOutlet var femaleButton: UIButton!
  @IBOutlet var maleButton: UIButton!
  @IBOutlet var ageCollectionView: UICollectionView!

  let minSpacing: CGFloat = 9

  let ages: [Age] = Age.allCases
  var selectedGender: Gender? {
    didSet {
      // MARK: TODO 델리게이트
    }
  }

  override init(frame: CGRect) {
      super.init(frame: frame)
      commonInit()
  }

  required public init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      commonInit()
  }

  func commonInit() {
      guard let view = Bundle.main.loadNibNamed(SelectingGenderAgeView.identifier, owner: self, options: nil)?.first as? UIView else { return }
      view.frame = self.bounds
      self.addSubview(view)

    setup()
  }

  func setup() {
    femaleButton.makeRounded(radius: 52/2)
    maleButton.makeRounded(radius: 52/2)
    let cell = UINib(nibName: AgeCollectionViewCell.identifier, bundle: nil)
    ageCollectionView.register(cell, forCellWithReuseIdentifier: AgeCollectionViewCell.identifier)
    ageCollectionView.reloadData()
    ageCollectionView.isUserInteractionEnabled = true
  }

  @IBAction func tapGender(_ sender: UIButton) {
    sender.isSelected = true
    sender.backgroundColor = .pink2
    selectedGender = sender == maleButton ? .male : .female

    let deselectedButton = sender == maleButton ? femaleButton : maleButton
    deselectedButton?.isSelected = false
    deselectedButton?.backgroundColor = .bg
  }
}

extension SelectingGenderAgeView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
  }
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return ages.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AgeCollectionViewCell.identifier, for: indexPath) as? AgeCollectionViewCell else {
      return UICollectionViewCell()
    }

    cell.titleLabel.text = ages[indexPath.row].cellText
    cell.setup(radius: collectionView.frame.height/2)
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let cellPadding: CGFloat = 9
    let availableWidth: CGFloat = (collectionView.frame.width - CGFloat(ages.count-1)*cellPadding)/CGFloat(ages.count)
    return CGSize(width: availableWidth, height: collectionView.frame.height)
  }
}
