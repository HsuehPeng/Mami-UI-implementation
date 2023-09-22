//
//  AppDelegate.swift
//  mamilove_interview
//
//  Created by Hsueh Peng Tseng on 2023/9/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		
		window = UIWindow()
		let viewController = ViewController()
		let navigationController = UINavigationController(rootViewController: viewController)
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
		
		return true
	}


}

