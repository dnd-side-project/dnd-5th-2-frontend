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

  let quizSet = QuizSet()
  private var questionSet = [Quiz]()
  private var answerSet: [Bool?] = Array(repeating: nil, count: 18)
  private var currentAnswerIndex = 0 {
    didSet {
      self.navigationItem.title = "\(currentAnswerIndex + 1) \\ \(answerSet.count)"
    }
  }

  weak var delegate: QuestionCellDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()
    setIntroductionLabel()
    questionSet = [quizSet.quiz(in: 0)]
    NotificationCenter.default.addObserver(self, selector: #selector(answerReceived(_:)), name: Notification.Name("handleAnswer"), object: nil)
    self.navigationItem.title = "1 \\ \(answerSet.count)"
  }

  @objc func answerReceived(_ notification: Notification) {
    let receivedObject = notification.object as! [Any]
    let answerIndex = receivedObject.first as! Int
    let answerValue = receivedObject.last as! Bool

    answerSet[answerIndex] = answerValue

    guard answerIndex < answerSet.count - 1 else {
      print("all answered button show")
      return
    }

    if answerIndex == questionSet.count - 1 {
     showNextQuestion()
    }
  }

  private func setIntroductionLabel() {
    introductionLabel.text = "좋아요. 이제\n아영님에 대해 알아볼게요."
    introductionLabel.numberOfLines = 2
    introductionLabel.font = UIFont.Pretendard(type: .Medium, size: 23)
  }

  private func showNextQuestion() {
    currentAnswerIndex += 1
    questionSet.append(quizSet.quiz(in: currentAnswerIndex))
    let indexPath = IndexPath(row: questionSet.count - 1, section: 0)
    tableView.insertRows(at: [indexPath], with: .none)
    tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
  }
}
extension OnboardingQuizViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return questionSet.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let questionCell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath) as! QuestionCell
    self.delegate = questionCell
    delegate?.setQuestionView(with: questionSet[indexPath.row], in: indexPath.row, checkedAnswer: answerSet[indexPath.row])
    return questionCell
  }
}
