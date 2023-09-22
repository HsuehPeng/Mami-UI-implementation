//
//  ViewController.swift
//  mamilove_interview
//
//  Created by Hsueh Peng Tseng on 2023/9/22.
//

import UIKit

class HomeViewController: UIViewController {
	// MARK: - Properties
	
	lazy var navigationBarBackgroundView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .systemPink
		view.alpha = 0
		return view
	}()
	
	lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.backgroundColor = .white
		return tableView
	}()
	
	// MARK: - LifeCycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configureNavBar()
		configureUI()
	}
}

// MARK: - UI Helpers

extension HomeViewController {
	private func configureNavBar() {
		title = "媽咪愛 UI實作"
		navigationController?.navigationBar.isTranslucent = true
		navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .topAttached, barMetrics: .default)
		navigationController?.navigationBar.shadowImage = UIImage()
		navigationController?.navigationBar.tintColor = .white
		navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Right", style: .plain, target: nil, action: nil)
	}
	
	private func configureUI() {
		view.addSubview(tableView)
		view.addSubview(navigationBarBackgroundView)

		NSLayoutConstraint.activate([
			navigationBarBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
			navigationBarBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			navigationBarBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			navigationBarBackgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
		])
		
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.topAnchor),
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
}

