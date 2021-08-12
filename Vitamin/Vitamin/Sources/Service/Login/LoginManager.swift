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

  let networkManager = NetworkManager.shared

  var currentUser: User?

  private init() { }

  func signup(user: User) {
    NetworkManager.shared.requestSignUp(with: user) { result in
      switch result {
      case .success(let user):
        self.currentUser = user
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }

  func login(loginUser: User,
             completionHandler: @escaping (Bool) -> Void) {
    networkManager.requestLogin(with: loginUser) { result in
      guard let result = result as? [String: String],
            let jwt = result["jwt"],
            let user = result["user"] else { // MARK: TODO 백엔드 기능 구현되면 user 체크
        completionHandler(false)
        return
      }

      let successToCreate = TokenUtils.shared.create(value: jwt)
      completionHandler(successToCreate)
    }
  }

  func login(completionHandler: @escaping (Bool) -> Void) {
    guard let header = TokenUtils.shared.getAuthorizationHeader() else {
      completionHandler(false)
      return
    }

    networkManager.requestLogin(with: header) { result in
      switch result {
      case .success(let user):
        self.currentUser = user
        completionHandler(true)
      case .failure(let error):
        print(error.localizedDescription)
        completionHandler(false)
      }
    }
  }

  func checkEmailExists(email: String, completion: @escaping (Bool) -> Void) {
    networkManager.checkEmailExisting(email: email) { result in
      guard let result = result as? [String: Bool],
            let exists = result["exists"],
            exists else {
        completion(false)
        return
      }
      completion(true)
    }
  }

  func logOut() {
    TokenUtils.shared.delete()
  }
}
