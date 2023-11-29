//
//  AppDelegate.swift
//  Calculator
//
//  Created by Yamazhiki on 2023/11/29.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
    window?.backgroundColor = .white
    window?.rootViewController = UINavigationController(rootViewController: vc)
    window?.makeKeyAndVisible()

    // Override point for customization after application launch.
    return true
  }

}
