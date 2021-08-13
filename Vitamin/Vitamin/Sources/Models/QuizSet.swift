//
//  QuizSet.swift
//  Vitamin
//
//  Created by 강인희 on 2021/08/09.
//

import Foundation

enum PersonalTypeCategory {
  case gut
  case stomach
  case bone
  case fatigue
  case eye
  case liver
}

struct Quiz {
  let category: PersonalTypeCategory
  let question: String
  let isKey: Bool
}

struct QuizSet {
  private let quizzes = [
    Quiz(category: .gut, question: "평소 변비,설사,복통 등이 있으신가요?", isKey: true),
    Quiz(category: .gut, question: "규칙적인 식사를 하시나요?", isKey: false),
    Quiz(category: .gut, question: "평소 스트레스를 많이 받으시나요?", isKey: false),
    Quiz(category: .stomach, question: "평소 위염 또는 위에 통증을 느끼시나요?", isKey: true),
    Quiz(category: .stomach, question: "규칙적인 식사를 하시나요?", isKey: false),
    Quiz(category: .stomach, question: "음주 또는 흡연을 자주 하시나요?", isKey: false),
    Quiz(category: .bone, question: "평소 관절 또는 뼈에 통증을 느끼시나요?", isKey: true),
    Quiz(category: .bone, question: "가공식품을 자주 드시나요?", isKey: false),
    Quiz(category: .bone, question: "과체중 또는 신체 활동량이 적으신 편인가요?", isKey: false),
    Quiz(category: .fatigue, question: "평소 잠을 자도 피곤한 느낌을 자주 받으시나요?", isKey: true),
    Quiz(category: .fatigue, question: "주기적인 운동을 하시나요?", isKey: false),
    Quiz(category: .fatigue, question: "커피를 자주 드시나요?", isKey: false),
    Quiz(category: .eye, question: "평소 눈에 피로감 또는 충혈이 자주 발생하나요?", isKey: true),
    Quiz(category: .eye, question: "눈 또는 입술이 자주 건조해지시나요?", isKey: false),
    Quiz(category: .eye, question: "하루 전자기기 사용시간이 3시간 이상인가요?", isKey: false),
    Quiz(category: .liver, question: "평소 복부 팽만 또는 통증을 느끼시나요?", isKey: true),
    Quiz(category: .liver, question: "피부가 자주 간지럽거나 건조함을 느끼시나요?", isKey: true),
    Quiz(category: .liver, question: "눈에 황달기가 있으신가요?", isKey: false)
  ]

  func quiz(in index: Int) -> Quiz {
    return self.quizzes[index]
  }
}