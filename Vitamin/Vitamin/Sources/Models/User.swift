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
  var types: [UserType] = []
  var profileImg: String?

  enum CodingKeys: String, CodingKey {
    case email
    case password
    case username = "user_name"
    case gender
    case age
    case types = "type_name"
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
      self.types = try values.decodeIfPresent([UserType].self, forKey: .types) ?? []
    } catch let error {
      print(error.localizedDescription)
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
      try container.encode(types, forKey: .types)
    } catch {

    }
  }
}

struct LoginResult: Codable {
  var token: String
  var user: User
}
