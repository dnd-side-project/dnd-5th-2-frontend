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

  func checkExists(feature: Feature, parameterValue: String, completionHandler: @escaping (Any?) -> Void) {
    let url = URLMaker.makeRequestURL(feature: feature)
    let parameter = [feature.parameterKey: parameterValue]
    let request = AF.request(url,
                             method: .post,
                             parameters: parameter,
                             encoder: JSONParameterEncoder.default)
    request.responseJSON { response in
      switch response.result {
      case .success:
        completionHandler(response.value)
      case .failure(let error):
        print(error.localizedDescription)
        completionHandler(nil)
      }
    }
  }

  func requestSignUp(with user: User,
                     completionHandler: @escaping (Bool) -> Void) {

    let signUpURL = URLMaker.makeRequestURL(feature: .signUp)
    let request = AF.request(signUpURL,
                             method: .post,
                             parameters: user,
                             encoder: JSONParameterEncoder.default)
      .validate(statusCode: 200..<300)

    request.response { response in
      switch response.result {
      case .success:
        completionHandler(true)
      case .failure(let error):
        print(error.localizedDescription)
        completionHandler(false)
      }
    }
  }

  func requestLogin(with loginUser: User,
                    completionHandler: @escaping (Result<LoginResult, Error>) -> Void) {

    let loginURL = URLMaker.makeRequestURL(feature: .login)
    let request = AF.request(loginURL,
                             method: .post,
                             parameters: loginUser,
                             encoder: JSONParameterEncoder.default)

    request.responseDecodable { (response: DataResponse<LoginResult, AFError>) in
      switch response.result {
      case .success(let loginResult):
        completionHandler(.success(loginResult))
      case .failure(let error):
        completionHandler(.failure(error))
      }
    }
  }

  func requestLogin(with header: HTTPHeaders,
                    completionHandler: @escaping (Result<User, Error>) -> Void) {

    let loginURL = URLMaker.makeRequestURL(feature: .autoLogin)
    let request = AF.request(loginURL,
                             method: .get,
                             headers: header)
    request.responseDecodable { (response: DataResponse<User, AFError>) in
      switch response.result {
      case .success(let user):
        completionHandler(.success(user))
      case .failure(let error):
        completionHandler(.failure(error))
      }
    }
  }

  func requestUserType(with header: HTTPHeaders,
                       _ typeArray: [String],
                       completionHandler: @escaping (Result<UserTypeResponse, Error>) -> Void) {

    let registerUserPersonalTypeURL = URLMaker.makeRequestURL(feature: .userType)
    let request = AF.request(registerUserPersonalTypeURL,
                             method: .post,
                             parameters: ["type_name": typeArray],
                             headers: header)

    request.responseDecodable { (response: DataResponse<UserTypeResponse, AFError>) in
      switch response.result {
      case .success(let userTypeResponse):
        completionHandler(.success(userTypeResponse))
      case .failure(let error):
        print(error.localizedDescription)
        completionHandler(.failure(error))
      }
    }
  }
}

struct UserTypeResponse: Codable {

}
