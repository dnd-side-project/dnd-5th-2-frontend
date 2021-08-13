//
//  UserInformation.swift
//  Vitamin
//
//  Created by Jinhyang on 2021/08/07.
//

import Foundation

enum Gender: String, Codable {
  case male = "남성"
  case female = "여성"
}

enum Age: Int, Codable, CaseIterable {
  case teen = 10
  case twenty = 20
  case thirty = 30
  case fourty = 40
  case elder = 50

  var cellText: String {
    switch self {
    case .teen:
      return "10대"
    case .twenty:
      return "20대"
    case .thirty:
      return "30대"
    case .fourty:
      return "40대"
    case .elder:
      return "50~"
    }
  }
}

enum UserType: String, Codable {
  case working = "직장인 유형"
}
