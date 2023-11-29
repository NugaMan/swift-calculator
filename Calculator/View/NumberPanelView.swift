//
//  NumberPanelView.swift
//  Calculator
//
//  Created by Yamazhiki on 2023/11/29.
//

import Foundation
import UIKit

@IBDesignable
class NumberPanelView: UIView {
  @IBOutlet private weak var resultLabel: UILabel!
  @IBOutlet private weak var detailLabel: UILabel!

  let provider = CalculatorProvider()

  var resultStr: String {
    return provider.result
  }

  @IBAction func click(_ sender: UIButton) {
    let keyType = (KeyType(rawValue: sender.tag)) ?? KeyType.clear
    provider.enterKey(key: keyType)
    showResult()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    loadXibView()
  }

  func clear() {
    provider.reset()
    showResult()
  }

  func resetResult(result: String) {
    provider.updateResult(result: result)
    showResult()
  }

  private func loadXibView() {
    let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: "NumberPanelView", bundle: bundle)
    let nibView = nib.instantiate(withOwner: self).first as? UIView
    guard let tView = nibView else { return }

    tView.translatesAutoresizingMaskIntoConstraints = false
    let constraints = [
      tView.trailingAnchor.constraint(equalTo: trailingAnchor),
      tView.leadingAnchor.constraint(equalTo: leadingAnchor),
      tView.bottomAnchor.constraint(equalTo: bottomAnchor),
      tView.topAnchor.constraint(equalTo: topAnchor),
    ]
    addSubview(tView)
    addConstraints(constraints)
    showResult()
  }

  private func showResult() {
    resultLabel.text = provider.result
    detailLabel.text = provider.detail
  }

  private func reset() {
    provider.reset()
  }
}
