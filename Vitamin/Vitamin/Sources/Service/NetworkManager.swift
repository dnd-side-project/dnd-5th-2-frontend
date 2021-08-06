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

  private init() { }

  func requestSignUp(with signUp: SignUp,
                     completionHandler: @escaping (Result<User, Error>) -> Void) {

    let signUpURL = URLMaker.makeRequestURL(feature: .signUp)

    let request = AF.request(signUpURL,
                             method: .post,
                             parameters: signUp)

    request.responseDecodable { (response: DataResponse<User, AFError>) in
      switch response.result {
      case .success(let user):
        completionHandler(.success(user))
      case .failure(let error):
        completionHandler(.failure(error))
      }
    }
  }
}
