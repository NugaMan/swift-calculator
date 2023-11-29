//
//  ViewController.swift
//  Calculator
//
//  Created by Yamazhiki on 2023/11/29.
//

import UIKit

enum ActionType: Int {
  case toLeft
  case toRight
  case reset
}

class ViewController: UIViewController {
  @IBOutlet weak var actionPanel: UIStackView!
  @IBOutlet weak var rightPanel: NumberPanelView!
  @IBOutlet weak var leftPanel: NumberPanelView!

  override func viewDidLoad() {
    super.viewDidLoad()
    updateLayout()
  }

  @IBAction func click(_ sender: UIButton) {
    let action = (ActionType(rawValue: sender.tag)) ?? ActionType.reset
    switch action {
    case .reset:
        leftPanel.clear()
        rightPanel.clear()
    case .toRight:
      rightPanel.resetResult(result: leftPanel.resultStr)
    default:
      leftPanel.resetResult(result: rightPanel.resultStr)
    }
  }

  override func viewWillTransition(
    to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator
  ) {
    updateLayout()
  }

  private func updateLayout() {
    let orientation = UIApplication.shared.statusBarOrientation
    let needHidden = orientation == .portrait || orientation == .portraitUpsideDown
    actionPanel.isHidden = needHidden
    rightPanel.isHidden = needHidden

    UIView.animate(withDuration: 0.4) {
      self.view.layoutIfNeeded()
    }
  }

}
