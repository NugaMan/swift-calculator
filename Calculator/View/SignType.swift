//
//  SignType.swift
//  Calculator
//
//  Created by Yamazhiki on 2023/11/29.
//

import Foundation

enum SignType: String {
  case positive = "+"
  case negative = "-"

  func toggle() -> SignType {
    switch self {
    case .positive:
      return .negative
    default:
      return .positive
    }
  }

  func detailDesc() -> String {
    switch self {
    case .positive:
      return ""
    default:
      return self.rawValue
    }
  }
}
