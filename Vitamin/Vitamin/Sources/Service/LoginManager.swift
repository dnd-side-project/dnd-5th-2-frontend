//
//  LoginManager.swift
//  Vitamin
//
//  Created by Jinhyang on 2021/08/06.
//

import Foundation

class LoginManager {

  static let shared = LoginManager()

  func signup(user: User) {
    NetworkManager.shared.requestSignUp(with: user) { result in
      switch result {
      case .success(let user):
        print(user.username)
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
}
