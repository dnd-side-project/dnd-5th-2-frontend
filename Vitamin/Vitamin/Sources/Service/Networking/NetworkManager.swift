//
//  NetworkManager.swift
//  Vitamin
//
//  Created by 강인희 on 2021/08/06.
//

import Foundation
import Alamofire

class NetworkManager {

  static let shared = NetworkManager()

  let jsonDecoder = JSONDecoder()

  private init() { }

  func requestSignUp(with user: User,
                     completionHandler: @escaping (Result<User, Error>) -> Void) {

    let signUpURL = URLMaker.makeRequestURL(feature: .signUp)
    let request = AF.request(signUpURL,
                             method: .post,
                             parameters: user)

    request.responseDecodable { (response: DataResponse<User, AFError>) in
      switch response.result {
      case .success(let user):
        completionHandler(.success(user))
      case .failure(let error):
        completionHandler(.failure(error))
      }
    }
  }

  func requestLogin(with loginUser: LoginUser,
                    completionHandler: @escaping (Any?) -> Void) {

    let loginURL = URLMaker.makeRequestURL(feature: .login)
    let request = AF.request(loginURL,
                             method: .post,
                             parameters: loginUser)

    request.responseJSON { response in
      switch response.result {
      case .success:
        completionHandler(response.value)
      case .failure(let error):
        print(error.localizedDescription)
        completionHandler(nil)
      }
    }
    completionHandler(true)
  }
}
