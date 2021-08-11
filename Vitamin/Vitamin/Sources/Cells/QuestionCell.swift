//
//  QuestionCell.swift
//  Vitamin
//
//  Created by 강인희 on 2021/08/09.
//

import Foundation
import UIKit

protocol QuestionCellDelegate: AnyObject {
  func setQuestionView(with quiz: Quiz, in index: Int, checkedAnswer: Bool?)
}

class QuestionCell: UITableViewCell, QuestionCellDelegate {
  @IBOutlet weak var questionView: UIView!
  @IBOutlet weak var answerView: UIView!
  @IBOutlet weak var questionTextLabel: UILabel!
  @IBOutlet weak var answerTextLabel: UILabel!
  @IBOutlet weak var yesButton: UIButton!
  @IBOutlet weak var noButton: UIButton!

  private var quizIndex: Int?

  @IBAction func tappedYesButton(_ sender: UIButton) {
    answerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    showAnswerView(with: "네 맞아요")
    NotificationCenter.default.post(name: Notification.Name("handleAnswer"), object: [self.quizIndex!, true], userInfo: nil)
  }

  @IBAction func tappedNoButton(_ sender: UIButton) {
    answerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    showAnswerView(with: "아니요")
    NotificationCenter.default.post(name: Notification.Name("handleAnswer"), object: [self.quizIndex!, false], userInfo: nil)
  }

  func setQuestionView(with quiz: Quiz, in index: Int, checkedAnswer: Bool?) {
    questionView.makeRounded(radius: 21)
    questionView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]

    questionTextLabel.text = quiz.question
    self.quizIndex = index
    questionTextLabel.font = UIFont.Pretendard(type: .Semibold, size: 15)

    yesButton.setTitle("네, 맞아요", for: .normal)
    yesButton.setTitleColor(.black, for: .normal)
    yesButton.makeRounded(radius: 13)
    yesButton.layer.borderWidth = 1.0
    yesButton.layer.borderColor = UIColor(red: 232/255, green: 232/255, blue: 238/255, alpha: 1).cgColor

    noButton.setTitle("아니오", for: .normal)
    noButton.setTitleColor(.black, for: .normal)
    noButton.makeRounded(radius: 13)
    noButton.layer.borderWidth = 1.0
    noButton.layer.borderColor = UIColor(red: 232/255, green: 232/255, blue: 238/255, alpha: 1).cgColor

    guard let answer = checkedAnswer else {
      answerView.isHidden = true
      return
    }

    answerView.isHidden = false
    answerTextLabel.text = answer ? "네 맞아요" : "아니요"
  }

  private func showAnswerView(with text: String) {
    answerView.isHidden = false
    answerView.makeRounded(radius: 21)
    answerTextLabel.text = text
    answerTextLabel.textColor = .white
  }
}
