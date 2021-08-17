//
//  URLMaker.swift
//  Vitamin
//
//  Created by 강인희 on 2021/08/06.
//

import Foundation
import Alamofire

enum Feature {

  case signUp
  case login
  case autoLogin
  case userSelfInformation
  case emailCheck
  case userType
  case usernameCheck

  var urlPath: String {
    switch self {
    case .signUp:
      return "/auth/signup"
    case .login:
      return "auth/login"
    case .autoLogin, .userSelfInformation:
      return "user"
    case .emailCheck:
      return "auth/signup-email"
    case .userType:
      return "user/type"
    case .usernameCheck:
      return "auth/signup-username"
    }
  }

  var parameterKey: String {
    switch  self {
    case .emailCheck:
      return "email"
    case .usernameCheck:
      return "username"
    default:
      return ""
    }
  }
}

struct URLMaker {
  static let baseURL = "https://63cce503-cc6a-4a4b-b954-040fc6ba31e3.mock.pstmn.io/"
  //  http://54.180.126.116/
  static func makeRequestURL(feature: Feature) -> String {
    return "\(self.baseURL)\(feature.urlPath)"
  }
}
