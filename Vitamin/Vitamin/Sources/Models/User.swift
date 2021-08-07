//
//  User.swift
//  Vitamin
//
//  Created by 강인희 on 2021/08/06.
//

import Foundation

class User: Codable {
  private var _email: String = ""
  private var _password: String = ""

  var email: String {
    get {
      return self._email
    }
  }

  var password: String {
    get {
      return self._password
    }
  }

  var username: String? = ""
  var gender: Gender?
  var age: Age?

  init(email: String, password: String, username: String) {
    self._email = email
    self.username = username
    self._password = password
  }

  func updatePassword(_ password: String) {
    self._password = password
  }
}
