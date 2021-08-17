//
//  SupplementDescriptionViewController.swift
//  Vitamin
//
//  Created by 강인희 on 2021/08/17.
//

import UIKit

class SupplementDescriptionViewController: UIViewController {

  @IBOutlet weak var imageScrollView: UIScrollView!
  @IBOutlet weak var imagesStackView: UIStackView!
  @IBOutlet weak var imagePageControl: UIPageControl!

  var imageViews = [UIImageView]()
  var images: [UIImage] = [#imageLiteral(resourceName: "close"), #imageLiteral(resourceName: "backButton"), #imageLiteral(resourceName: "loginLogo"), #imageLiteral(resourceName: "loginLogo")]

  override func viewDidLoad() {
    super.viewDidLoad()
    imageScrollView.delegate = self
    setPageControl()
    setImagesStackView()
  }

  private func setImagesStackView() {
    for imageIndex in 0 ..< images.count {
     let imageView = UIImageView()
      let xPos = imageScrollView.frameLayoutGuide.layoutFrame.width * CGFloat(imageIndex + 4)
      imageView.frame = CGRect(x: xPos, y: 0, width: imageScrollView.frameLayoutGuide.layoutFrame.width, height: 200)
      imageView.image = images[imageIndex]
      imageView.contentMode = .scaleAspectFit
      imagesStackView.addArrangedSubview(imageView)
    }
  }

  private func setPageControl() {
    imagePageControl.numberOfPages = images.count
  }

  private func setPageControlSelectedPage(currentPage: Int) {
    imagePageControl.currentPage = currentPage
  }
}
extension SupplementDescriptionViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let value = scrollView.contentOffset.x/scrollView.frame.size.width
    setPageControlSelectedPage(currentPage: Int(round(value)))
  }
}
