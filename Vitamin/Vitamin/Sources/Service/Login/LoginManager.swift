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

  var currentUser: User?

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
      guard let result = result as? [String: String],
            let jwt = result["jwt"],
            let user = result["user"] else { // MARK: TODO 백엔드 기능 구현되면 user 체크
        completionHandler(false)
        return
      }

      let token = TokenUtils()
      let successToCreate = token.create(account: "accessToken", value: jwt)
      completionHandler(successToCreate)
    }
  }
}
