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

  /// 회원가입에 성공하면 로그인 요청
  /// 로그인에 성공하면 completionHandler로 성공 여부를 전달
  func signup(user: User,
              completionHandler: @escaping (Bool) -> Void) {
    networkManager.requestSignUp(with: user) { [weak self] result in
      switch result {
      case .success(let user):
        self?.login(loginUser: user, completionHandler: { success in
          completionHandler(success)
        })
      case .failure(let error):
        print(error.localizedDescription)
        completionHandler(false)
      }
    }
  }

  func login(loginUser: User,
             completionHandler: @escaping (Bool) -> Void) {
    networkManager.requestLogin(with: loginUser) { result in
      guard let result = result as? [String: Any],
            let jwt = result["jwt"] as? String,
            let user = result["user"] as? User else { // MARK: TODO 백엔드 응답값 반영되면 확인하기
        completionHandler(false)
        return
      }

      let successToCreate = TokenUtils.shared.create(value: jwt)
      self.currentUser = user
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
    networkManager.checkExists(parameter: ["email": email]) { result in
      guard let result = result as? [String: Bool],
            let exists = result["exists"],
            exists else {
        completion(false)
        return
      }
      completion(true)
    }
  }

  func checkNickNameExists(nickName: String, completion: @escaping (Bool) -> Void) {
    networkManager.checkExists(parameter: ["username": nickName]) { result in
      guard let result = result as? [String: Bool],
            let exists = result["exists"],
            exists else {
        completion(false)
        return
      }
      completion(true)
    }
  }

  func registerUserType(typeArray: [String], completionHandler: @escaping(Any?) -> Void) {
    guard let header = TokenUtils.shared.getAuthorizationHeader() else {
      completionHandler(false)
      return
    }

    networkManager.requestUserType(with: header,
                                   typeArray) { result in
      print(result)
    }
  }

  func logOut() {
    TokenUtils.shared.delete()
  }
}
