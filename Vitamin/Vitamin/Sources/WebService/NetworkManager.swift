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
  
  func requestSignUp(with signUp: SignUp) {
    AF.request("https://63cce503-cc6a-4a4b-b954-040fc6ba31e3.mock.pstmn.io/auth/signup",
               method: .post,
               parameters: signUp,
               encoder: JSONParameterEncoder.default)
      .validate(statusCode: 200..<300)
      .validate(contentType: ["application/json"])
      .responseData(emptyResponseCodes: [200, 204, 205]) { response in
        switch response.result {
        case .success:
          // User 모델 생성 과정 추가 필요
        case .failure(let error):
          // 회원가입 실패에 따른 처리 필요
          debugPrint("회원가입 실패")
        }
      }
  }
  
}
