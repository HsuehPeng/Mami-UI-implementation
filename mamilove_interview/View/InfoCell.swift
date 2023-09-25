//
//  CheckoutTableViewCell.swift
//  mamilove_interview
//
//  Created by Hsueh Peng Tseng on 2023/9/22.
//

import UIKit

final class InfoCell: UITableViewCell {
	// MARK: - Properties
	
	lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 14)
		return label
	}()
	
	lazy var subTitleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 0
		return label
	}()
	
	lazy var arrowButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setImage(UIImage(named: "chevron_left"), for: .normal)
		return button
	}()
	
	// MARK: - LifeCycle

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		configureUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - UI Helpers
	
	private func configureUI() {
		contentView.addSubview(titleLabel)
		contentView.addSubview(subTitleLabel)
		contentView.addSubview(arrowButton)

		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
			titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8)
		])
		
		NSLayoutConstraint.activate([
			subTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
			subTitleLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
			subTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
		])
		
		NSLayoutConstraint.activate([
			arrowButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			arrowButton.leadingAnchor.constraint(equalTo: subTitleLabel.trailingAnchor, constant: 32),
			arrowButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
			arrowButton.widthAnchor.constraint(equalToConstant: 18),
			arrowButton.heightAnchor.constraint(equalToConstant: 18)
		])
	}
}
