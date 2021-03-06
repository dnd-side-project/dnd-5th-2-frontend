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
  var urlPath: String {
    switch self {
    case .signUp:
      return "/auth/signup"
    }
  }
}

struct URLMaker {
  static let baseURL = "https://63cce503-cc6a-4a4b-b954-040fc6ba31e3.mock.pstmn.io/"
  static func makeRequestURL(feature: Feature) -> String {
    return "\(self.baseURL)\(feature.urlPath)"
  }
}
