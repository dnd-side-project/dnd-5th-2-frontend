//
//  User.swift
//  Vitamin
//
//  Created by 강인희 on 2021/08/06.
//

import Foundation

struct User: Codable {
  var email: String?
  var password: String?

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

  init() { }

  init(from decoder: Decoder) throws {
    do {
      let values = try decoder.container(keyedBy: CodingKeys.self)
      self.email = try values.decode(String.self, forKey: .email)
      self.password = try values.decodeIfPresent(String.self, forKey: .password) ?? ""
      self.username = try values.decodeIfPresent(String.self, forKey: .username)
      self.gender = try values.decodeIfPresent(Gender.self, forKey: .gender)
      self.age = try values.decodeIfPresent(Age.self, forKey: .age)
      self.type = try values.decodeIfPresent(UserType.self, forKey: .type)
    } catch {

    }
  }

  func encode(to encoder: Encoder) throws {
    do {
      var container = encoder.container(keyedBy: CodingKeys.self)
      try container.encode(email, forKey: .email)
      try container.encode(password, forKey: .password)
      try container.encode(username, forKey: .username)
      try container.encode(age, forKey: .age)
      try container.encode(gender, forKey: .gender)
      try container.encode(type, forKey: .type)
    } catch {

    }
  }
}

struct LoginResult: Codable {
  var token: String
  var user: User
}
