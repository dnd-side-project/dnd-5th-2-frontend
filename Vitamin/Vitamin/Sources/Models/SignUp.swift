//
//  SignUp.swift
//  Vitamin
//
//  Created by 강인희 on 2021/08/06.
//

import Foundation

enum Gender: String, Encodable {
  case male = "남"
  case female = "여"
}

enum Age: Int, Encodable {
  case teen = 10
  case twenty = 20
  case thirty = 30
  case fourty = 40
  case fifty = 50
  case elder = 60
}

struct SignUp: Encodable {
  let email: String
  let username: String
  let age: Age
  let gender: Gender
  let password: String
}
