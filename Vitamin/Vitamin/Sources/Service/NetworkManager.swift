//
//  NetworkManager.swift
//  Vitamin
//
//  Created by 강인희 on 2021/08/06.
//

import Foundation
import Alamofire
import JWTDecode

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
                    completionHandler: @escaping (Bool) -> Void) {
    
    let loginURL = URLMaker.makeRequestURL(feature: .login)
    let request = AF.request(loginURL,
                             method: .post,
                             parameters: loginUser)
    
    request.responseJSON { response in
      switch response.result {
      case .success:
        guard let tokenData = response.value as? [String: String],
              let jwt = tokenData["jwt"] else {
          completionHandler(false)
          return
        }
        
        let _ = self.generateToken(jwt: jwt)
        
      case .failure(let error):
        print(error.localizedDescription)
        completionHandler(false)
      }
    }
    completionHandler(true)
  }
  
  func generateToken(jwt: String) -> Bool {
    do {
      let jwt = try decode(jwt: jwt)
      
      return true
    } catch let error {
      print(error.localizedDescription)
      return false
    }
  }
}
