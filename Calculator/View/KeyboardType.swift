//
//  KeyboardType.swift
//  Calculator
//
//  Created by Yamazhiki on 2023/11/29.
//

import Foundation

enum KeyType: Int {
  case zero
  case one
  case two
  case three
  case four
  case five
  case six
  case seven
  case eight
  case nine = 9
  case clear
  case sign
  case percent = 12
  case division
  case multi
  case minus
  case add = 16
  case dot
  case equal

  var opString: String {
    switch self {
    case .add:
      return "+"
    case .minus:
      return "-"
    case .division:
      return "÷"
    case .multi:
      return "×"
    default:
      return ""
    }
  }
}
