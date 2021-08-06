//
//  LoginManager.swift
//  Vitamin
//
//  Created by Jinhyang on 2021/08/06.
//

import Foundation
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

  func login(loginUser: LoginUser,
             completionHandler: @escaping (Bool) -> Void) {
    NetworkManager.shared.requestLogin(with: loginUser) { result in
      guard let tokenData = result as? [String: String],
            let jwt = tokenData["jwt"] else {
        completionHandler(false)
        return
      }

      let token = TokenUtils()
      let successToCreate = token.create(account: "accessToken", value: jwt) // MARK: - token 종류 확인하기
      completionHandler(successToCreate)
    }
  }
}
