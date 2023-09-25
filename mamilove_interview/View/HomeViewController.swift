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
		let tableView = UITableView(frame: .zero, style: .grouped)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.backgroundColor = .white
		return tableView
	}()
	
	let viewModel: HomeViewControllerViewModel
	
	// MARK: - LifeCycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configureNavBar()
		configureUI()
		configureTableView()
		
		viewModel.loadCheckoutInfo()
	}
	
	init(viewModel: HomeViewControllerViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.checkoutInfoCellViewModels.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeue(InfoCell.self, for: indexPath) as! InfoCell
		let paymentCellVM = viewModel.checkoutInfoCellViewModels[indexPath.row]
		cell.titleLabel.text = paymentCellVM.title
		cell.subTitleLabel.attributedText = paymentCellVM.subTitle
		cell.arrowButton.isHidden = paymentCellVM.isArrowButtonHidden
		return cell
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: ColorImageTableViewCell.self))
		return header
	}
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 300
	}
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let contentOffsetY = scrollView.contentOffset.y
		setNavBarBackgroundViewAlpha(by: contentOffsetY)
	}
	
	private func setNavBarBackgroundViewAlpha(by offset: CGFloat) {
		guard offset > 0 else {
			navigationBarBackgroundView.alpha = 0
			return
		}
		
		let alpha = offset / 150
		navigationBarBackgroundView.alpha = alpha > 1 ? 1 : alpha
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
		tableView.separatorStyle = .singleLine
		tableView.register(ColorImageTableViewCell.self, forHeaderFooterViewReuseIdentifier: String(describing: ColorImageTableViewCell.self))
		tableView.register(InfoCell.self)
	}
}

