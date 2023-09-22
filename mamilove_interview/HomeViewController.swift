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
		configureTableView()
	}
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ColorImageTableViewCell.self), for: indexPath) as? ColorImageTableViewCell else { return UITableViewCell() }
		
		return cell
	}
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.row == 0 {
			return 300
		}
		
		return UITableView.automaticDimension
	}
}

// MARK: - UI Helpers

extension HomeViewController {
	private func configureNavBar() {
		title = "媽咪愛 UI實作"
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
	
	private func configureTableView() {
		tableView.dataSource = self
		tableView.delegate = self
		tableView.contentInsetAdjustmentBehavior = .never
		tableView.separatorStyle = .none
		tableView.register(ColorImageTableViewCell.self, forCellReuseIdentifier: String(describing: ColorImageTableViewCell.self))
	}
}

