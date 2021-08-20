//
//  LoginFailureViewController.swift
//  Vitamin
//
//  Created by Jinhyang on 2021/08/17.
//

import UIKit

class LoginFailureViewController: UIViewController {

  @IBOutlet var imageTopConstraint: NSLayoutConstraint!
  @IBOutlet var dismissButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.navigationBar.isHidden = true
    dismissButton.makeRounded(radius: 13)
  }

  override func viewDidLayoutSubviews() {
    imageTopConstraint.constant = view.frame.height * 0.20935
  }

  @IBAction func dismiss(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
}
