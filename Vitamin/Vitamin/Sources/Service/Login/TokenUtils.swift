//
//  TokenUtils.swift
//  Vitamin
//
//  Created by Jinhyang on 2021/08/07.
//

import Security
import Alamofire

class TokenUtils {

  static let shared = TokenUtils()
  fileprivate let account: String = "accessToken"

  private init() { }

  let service = Bundle.main.bundleIdentifier!

  func create(value: String) -> Bool {
    let keyChainQuery: NSDictionary = [
      kSecClass: kSecClassGenericPassword,
      kSecAttrService: service,
      kSecAttrAccount: account,
      kSecValueData: value.data(using: .utf8, allowLossyConversion: false)!
    ]

    SecItemDelete(keyChainQuery)
    return SecItemAdd(keyChainQuery, nil) == errSecSuccess
  }

  func read() -> String? {
    let KeyChainQuery: NSDictionary = [
      kSecClass: kSecClassGenericPassword,
      kSecAttrService: service,
      kSecAttrAccount: account,
      kSecReturnData: kCFBooleanTrue,
      kSecMatchLimit: kSecMatchLimitOne
    ]

    var dataTypeRef: AnyObject?
    let status = SecItemCopyMatching(KeyChainQuery, &dataTypeRef)

    if status == errSecSuccess {
      let retrievedData = dataTypeRef as! Data
      let value = String(data: retrievedData, encoding: String.Encoding.utf8)
      return value
    } else {
      print("failed to loading, status code = \(status)")
      return nil
    }
  }

  func delete() {
    let keyChainQuery: NSDictionary = [
      kSecClass: kSecClassGenericPassword,
      kSecAttrService: service,
      kSecAttrAccount: account
    ]

    SecItemDelete(keyChainQuery)
  }

  func getAuthorizationHeader() -> HTTPHeaders? {
    if let accessToken = self.read() {
      return ["Authorization": "bearer \(accessToken)"] as HTTPHeaders
    } else {
      return nil
    }
  }
}
