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
		let homeViewControllerVM = HomeViewControllerViewModel(checkoutInfoLoader: MockCheckoutInfoLoader(), checkoutInfoCellViewModelMapper: CheckoutInfoUIKitPresentationMapper())
		let homeViewController = HomeViewController(viewModel: homeViewControllerVM)
		let navigationController = UINavigationController(rootViewController: homeViewController)
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
		
		return true
	}


}

