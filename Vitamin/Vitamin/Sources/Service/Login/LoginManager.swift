//
//  LoginManager.swift
//  Vitamin
//
//  Created by Jinhyang on 2021/08/06.
//

import Foundation
import JWTDecode
import Alamofire

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
    NetworkManager.shared.requestLogin(with: loginUser) { result in
      guard let tokenData = result as? [String: String],
            let jwt = tokenData["jwt"] else {
        // MARK: - 핸들링
        return
      }

    }
  }
}
