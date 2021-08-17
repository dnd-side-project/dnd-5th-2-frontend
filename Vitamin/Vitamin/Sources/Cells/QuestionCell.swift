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
  @IBOutlet weak var askDotView: UIImageView!
  @IBOutlet weak var answerTextLabel: UILabel!
  @IBOutlet weak var yesButton: UIButton!
  @IBOutlet weak var noButton: UIButton!

  private var quizIndex: Int?

  @IBAction func tappedYesButton(_ sender: UIButton) {
    if noButton.isSelected {
      noButton.isSelected = false
      noButton.backgroundColor = .white
      noButton.layer.borderWidth = 1.0
      noButton.layer.borderColor = UIColor(red: 232/255, green: 232/255, blue: 238/255, alpha: 1).cgColor
    }

    sender.isSelected = true
    sender.backgroundColor = UIColor(red: 232/255, green: 232/255, blue: 238/255, alpha: 1)
    showAnswerView(with: "네, 맞아요")
    NotificationCenter.default.post(name: Notification.Name("handleAnswer"), object: [self.quizIndex!, true], userInfo: nil)
  }

  @IBAction func tappedNoButton(_ sender: UIButton) {
    if yesButton.isSelected {
      yesButton.isSelected = false
      yesButton.backgroundColor = .white
      yesButton.layer.borderWidth = 1.0
      yesButton.layer.borderColor = UIColor(red: 232/255, green: 232/255, blue: 238/255, alpha: 1).cgColor
    }

    sender.isSelected = true
    yesButton.isSelected = false
    sender.backgroundColor = UIColor(red: 232/255, green: 232/255, blue: 238/255, alpha: 1)
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
    noButton.setTitleColor(UIColor(red: 199/255, green: 199/255, blue: 206/255, alpha: 1), for: .selected)
    noButton.makeRounded(radius: 13)
    noButton.layer.borderWidth = 1.0
    noButton.layer.borderColor = UIColor(red: 232/255, green: 232/255, blue: 238/255, alpha: 1).cgColor

    guard let answer = checkedAnswer else {
      askDotView.isHidden = false
      answerTextLabel.isHidden = true
      answerView.makeRounded(radius: 21)
      answerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner]
      noButton.isSelected = false
      noButton.backgroundColor = .white
      noButton.layer.borderWidth = 1.0
      noButton.layer.borderColor = UIColor(red: 232/255, green: 232/255, blue: 238/255, alpha: 1).cgColor

      yesButton.isSelected = false
      yesButton.backgroundColor = .white
      yesButton.layer.borderWidth = 1.0
      yesButton.layer.borderColor = UIColor(red: 232/255, green: 232/255, blue: 238/255, alpha: 1).cgColor

      return
    }

    let answerText = answer ? "네, 맞아요" : "아니요"

    if answer {
      noButton.isSelected = false
      noButton.backgroundColor = .white
      noButton.layer.borderWidth = 1.0
      noButton.layer.borderColor = UIColor(red: 232/255, green: 232/255, blue: 238/255, alpha: 1).cgColor

      yesButton.isSelected = true
      yesButton.backgroundColor = UIColor(red: 232/255, green: 232/255, blue: 238/255, alpha: 1)
    } else {
      yesButton.isSelected = false
      yesButton.backgroundColor = .white
      yesButton.layer.borderWidth = 1.0
      yesButton.layer.borderColor = UIColor(red: 232/255, green: 232/255, blue: 238/255, alpha: 1).cgColor

      noButton.isSelected = true
      noButton.backgroundColor = UIColor(red: 232/255, green: 232/255, blue: 238/255, alpha: 1)
    }

    showAnswerView(with: answerText)
  }

  private func showAnswerView(with text: String) {
    askDotView.isHidden = true
    answerTextLabel.isHidden = false
    answerView.makeRounded(radius: 21)
    answerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner]
    answerTextLabel.text = text
    answerTextLabel.textColor = .white
  }
}
