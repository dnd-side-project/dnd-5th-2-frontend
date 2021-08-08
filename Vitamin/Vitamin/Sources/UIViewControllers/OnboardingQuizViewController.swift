//
//  OnboardingQuizViewController.swift
//  Vitamin
//
//  Created by 강인희 on 2021/08/08.
//

import UIKit

class OnboardingQuizViewController: UIViewController {
  @IBOutlet weak var introductionLabel: UILabel!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var noButton: UIButton!
  @IBOutlet weak var yesButton: UIButton!

  let quizSet = QuizSet()
  private var questionSet = [(Quiz, Bool?)]()

  weak var delegate: QuestionCellDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()
    setIntroductionLabel()
    setButtons()
    questionSet.append((quizSet.quiz(in: 0), nil))
  }

  @IBAction func tappedYesButton(_ sender: UIButton) {
    questionSet[0].1 = true
    self.delegate = tableView.cellForRow(at: [0, 0]) as! QuestionCell
    delegate?.showAnswerView(with: "네 맞아요")
  }

  @IBAction func tappedNoButton(_ sender: UIButton) {
    questionSet[0].1 = false
    self.delegate = tableView.cellForRow(at: [0, 0]) as! QuestionCell
    delegate?.showAnswerView(with: "아니요")
  }

  private func setIntroductionLabel() {
    introductionLabel.text = "좋아요. 이제\n아영님에 대해 알아볼게요."
    introductionLabel.numberOfLines = 2
    introductionLabel.font = UIFont.Pretendard(type: .Medium, size: 23)
  }

  private func setButtons() {
    noButton.layer.borderWidth = 1.0
    noButton.layer.borderColor = UIColor(red: 225/255, green: 225/255, blue: 232/255, alpha: 1).cgColor
    noButton.setTitleColor(.black, for: .normal)
    noButton.makeRounded(radius: noButton.frame.height / 2)
    noButton.setTitle("아니오", for: .normal)

    yesButton.layer.borderWidth = 1.0
    yesButton.layer.borderColor = UIColor(red: 225/255, green: 225/255, blue: 232/255, alpha: 1).cgColor
    yesButton.setTitleColor(.black, for: .normal)
    yesButton.makeRounded(radius: noButton.frame.height / 2)
    yesButton.setTitle("네", for: .normal)
  }
}
extension OnboardingQuizViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return questionSet.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let questionCell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath) as! QuestionCell
    let currentQuestion = questionSet[indexPath.row]

    self.delegate = questionCell
    delegate?.setQuestionView(with: currentQuestion.0.question)
    return questionCell
  }
}
