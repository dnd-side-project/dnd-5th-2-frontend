//
//  QuestionCell.swift
//  Vitamin
//
//  Created by 강인희 on 2021/08/09.
//

import Foundation
import UIKit

protocol QuestionCellDelegate: AnyObject {
  func setQuestionView(with text: String)
  func showAnswerView()
}

class QuestionCell: UITableViewCell, QuestionCellDelegate {
  @IBOutlet weak var questionView: UIView!
  @IBOutlet weak var answerView: UIView!
  @IBOutlet weak var questionTextLabel: UILabel!

  func setQuestionView(with text: String) {
    questionView.makeRounded(radius: questionView.frame.height / 2)
    questionView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    questionTextLabel.text = text
  }

  func showAnswerView() {
    answerView.isHidden = false
    answerView.makeRounded(radius: answerView.frame.height / 2)
    answerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
  }
}
