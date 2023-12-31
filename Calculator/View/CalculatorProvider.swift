//
//  CalculatorProvider.swift
//  Calculator
//
//  Created by Yamazhiki on 2023/11/29.
//

import Foundation

class CalculatorProvider {
  private var leftSign = SignType.positive
  private var leftNum = ""
  private var rightSign = SignType.positive
  private var rightNum = ""
  private var resultNum = ""
  private var op: KeyType?
  private var formatter = NumberFormatter()

  private let maxLen = 9

  init() {
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = maxLen
  }

  let error = "Error"

  var detail: String {
    if leftNum.isEmpty { return "0" }
    return
      "\(leftSign.detailDesc())\(leftNum) \( op?.opString ?? "") \(rightSign.detailDesc())\(rightNum) \(!resultNum.isEmpty ? "= \(result)" : "")"
  }

  var result: String {
    return resultNum
  }

  func updateResult(result: String) {
    if result != error {
      reset()
      leftNum = result
    }
  }

  func reset(reLeftOp: Bool = false, lSign: Bool = false) {
    leftSign = lSign ? SignType.negative : SignType.positive
    leftNum = ""
    rightSign = SignType.positive
    rightNum = ""
    op = nil
    if reLeftOp {
      leftNum = resultNum
    }
    resultNum = ""
  }

  func enterKey(key: KeyType) {
    switch key {
    case .clear:
      reset()
    case .sign:
      if !resultNum.isEmpty && resultNum != error {
        let hasSign = resultNum.hasPrefix("-")
        if hasSign {
          resultNum.removeFirst()
        }
        reset(reLeftOp: true, lSign: !hasSign)
      } else {
        if let _ = op {
          if !rightNum.isEmpty && rightNum != "0" {
            rightSign = rightSign.toggle()
          }
        } else {
          if !leftNum.isEmpty && leftNum != "0" {
            leftSign = leftSign.toggle()
          }
        }
      }
    case .percent:
      if !resultNum.isEmpty {
        reset(reLeftOp: true)
        if let v = formatter.number(from: leftNum)?.doubleValue {
          leftNum = "\(v * 0.01)"
        }
      } else {
        if let _ = op {
          if let r = formatter.number(from: rightNum)?.doubleValue {
            if let target = formatter.string(from: NSNumber(value: r / 100)) {
              rightNum = target
            }
          }
        } else {
          if let l = formatter.number(from: leftNum)?.doubleValue {
            if let target = formatter.string(from: NSNumber(value: l / 100)) {
              leftNum = target
            }
          }
        }
      }
    case .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .zero:
      if !resultNum.isEmpty {
        reset()
        leftNum = "\(key.rawValue)"

      } else {
        if let _ = op {
          if rightNum.count < maxLen {
            rightNum = rightNum + "\(key.rawValue)"
          }
        } else {
          if leftNum.count < maxLen {
            leftNum += "\(key.rawValue)"
          }
        }
      }
    case .add, .minus, .division, .multi:
      if !resultNum.isEmpty && resultNum != error {
        reset(reLeftOp: true)
        op = key
      } else {
        if !rightNum.isEmpty {
          if calculator() {
            reset(reLeftOp: true)
            op = key
          }
        } else {
          if !leftNum.isEmpty {
            op = key
          }
        }
      }

    case .dot:
      if !resultNum.isEmpty {
      } else {
        if let _ = op {
          rightNum = appendDot(numStr: rightNum)
        } else {
          leftNum = appendDot(numStr: leftNum)
        }
      }
    case .equal:
      if !leftNum.isEmpty && !rightNum.isEmpty {
        let _ = calculator()
      }
    }
  }

  private func calculator() -> Bool {
    if !resultNum.isEmpty {
      return true
    }
    var lnd = leftNum
    if lnd.hasSuffix(".") {
      lnd.removeLast()
    }
    var rnd = rightNum
    if rnd.hasSuffix(".") {
      rnd.removeLast()
    }
    let lo = formatter.number(from: "\(leftSign.detailDesc())\(lnd)")?.doubleValue ?? 0
    let ro = formatter.number(from: "\(rightSign.detailDesc())\(rnd)")?.doubleValue ?? 0
    var r: Double = 0

    switch op {
    case .add:
      r = lo + ro
    case .minus:
      r = lo - ro
    case .division:
      if ro == 0 {
        resultNum = "Error"
        return false
      } else {
        r = lo / ro
      }
    case .multi:
      r = lo * ro
    default:
      break
    }
    resultNum = formatter.string(from: NSNumber(value: r)) ?? ""
    return true
  }

  private func appendDot(numStr: String) -> String {
    var result: String = numStr
    if !result.contains(".") {
      if result.isEmpty {
        result = "0"
      }
      result = "\(result)."
    }
    return result
  }
}
