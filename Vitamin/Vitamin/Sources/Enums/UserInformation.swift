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

enum Age: Int, Codable {
  case teen = 10
  case twenty = 20
  case thirty = 30
  case fourty = 40
  case fifty = 50
  case elder = 60
}

enum UserType: String, Codable {
  case working = "직장인 유형"
}
