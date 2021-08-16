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
  @IBOutlet weak var submitButton: UIButton!

  let quizSet = QuizSet()
  private var questionSet = [Quiz]()
  private var answerSet: [Bool?] = Array(repeating: nil, count: 18)
  private var currentAnswerIndex = 0 {
    didSet {
      self.navigationItem.title = "\(currentAnswerIndex + 1) \\ \(answerSet.count)"
    }
  }
  private var personalTypeResult: [PersonalTypeCategory]?

  weak var delegate: QuestionCellDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()
    setIntroductionLabel()
    questionSet = [quizSet.quiz(in: 0)]
    NotificationCenter.default.addObserver(self, selector: #selector(answerReceived(_:)), name: Notification.Name("handleAnswer"), object: nil)
    self.navigationItem.title = "1 \\ \(answerSet.count)"
    submitButton.setTitle("제출하기", for: .normal)
    submitButton.isHidden = true
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showOnboardingResult" {
      let resultViewController = segue.destination as! OnboardingResultViewController
      resultViewController.personalTypeResult = Set(self.personalTypeResult ?? [])
    }
  }

  @objc func answerReceived(_ notification: Notification) {
    let receivedObject = notification.object as! [Any]
    let answerIndex = receivedObject.first as! Int
    let answerValue = receivedObject.last as! Bool

    answerSet[answerIndex] = answerValue

    guard answerIndex < answerSet.count - 1 else {
      calculateUserPersonalType()
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

    Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { _ in
      self.questionSet.append(self.quizSet.quiz(in: self.currentAnswerIndex))
      let indexPath = IndexPath(row: self.questionSet.count - 1, section: 0)
      self.tableView.insertRows(at: [indexPath], with: .none)
      self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
  }

  private func calculateUserPersonalType() {
    personalTypeResult = zip(questionSet, answerSet).filter({ (quiz, answer) in
      quiz.isKey == true && answer == true
    }).map { (quiz, _) in
      quiz.category
    }

    submitButton.isHidden = false
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
