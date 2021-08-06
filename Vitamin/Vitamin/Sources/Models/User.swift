//
//  User.swift
//  Vitamin
//
//  Created by 강인희 on 2021/08/06.
//

import Foundation

class User: Codable {
  var email: String = ""
  var username: String = ""
  var gender: Gender
  var age: Age
  var password: String = ""
}
