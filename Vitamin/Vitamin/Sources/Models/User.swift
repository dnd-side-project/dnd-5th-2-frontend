//
//  User.swift
//  Vitamin
//
//  Created by 강인희 on 2021/08/06.
//

import Foundation

// MARK: TODO - 이후 Enums 파일로 옮길 것
enum Gender: String, Codable {
  case male = "남"
  case female = "여"
}

enum Age: Int, Codable {
  case teen = 10
  case twenty = 20
  case thirty = 30
  case fourty = 40
  case fifty = 50
  case elder = 60
}

class User: Codable {
  var email: String = ""
  var password: String = ""
  var username: String? = ""
  var gender: Gender?
  var age: Age?

  init(email: String, password: String, username: String) {
    self.email = email
    self.username = username
    self.password = password
  }
}
