//
//  LoginManager.swift
//  Vitamin
//
//  Created by Jinhyang on 2021/08/06.
//

import Foundation

class LoginManager {

  static let shared = LoginManager()

  private init() { }

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

  func login(loginUser: LoginUser) {
    NetworkManager.shared.requestLogin(with: loginUser) { success in
      guard success else {
        // MARK: TODO - 실패처리
        return
      }
    }
  }
}
