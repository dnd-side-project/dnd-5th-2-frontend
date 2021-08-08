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
      return ""
    }
  }

  var username: String? = ""
  var gender: Gender?
  var age: Age?
  var type: UserType?
  var profileImg: String?

  enum CodingKeys: String, CodingKey {
    case email
    case password
    case username
    case gender
    case age
    case type
  }

  required init(from decoder: Decoder) throws {
    do {
      let values = try decoder.container(keyedBy: CodingKeys.self)
      self._password = try values.decodeIfPresent(String.self, forKey: .password) ?? ""
      self._email = try values.decode(String.self, forKey: .email)
      self.username = try values.decodeIfPresent(String.self, forKey: .username)
      self.gender = try values.decodeIfPresent(Gender.self, forKey: .gender)
      self.age = try values.decodeIfPresent(Age.self, forKey: .age)
      self.type = try values.decodeIfPresent(UserType.self, forKey: .type)
    } catch {

    }
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(email, forKey: .email)
    try container.encode(password, forKey: .password)
    try container.encode(username, forKey: .username)
    try container.encode(age, forKey: .age)
    try container.encode(gender, forKey: .gender)
    try container.encode(type, forKey: .type)
  }

  init(email: String, password: String, username: String) {
    self._email = email
    self.username = username
    self._password = password
  }

  func updatePassword(_ password: String) {
    self._password = password
  }
}
