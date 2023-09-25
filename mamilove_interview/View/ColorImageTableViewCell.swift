//
//  File.swift
//  mamilove_interview
//
//  Created by Hsueh Peng Tseng on 2023/9/22.
//

import UIKit

class ColorImageTableViewCell: UITableViewHeaderFooterView {
	lazy var imageLayer: CALayer = {
		let colorImage = UIImage.make(withColor: .darkGray)
		let imageLayer = CALayer()
		imageLayer.contents = colorImage.cgImage
		return imageLayer
	}()
	
	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		configureUI()
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		imageLayer.frame = contentView.bounds
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func configureUI() {
		imageLayer.frame = contentView.bounds
		contentView.layer.addSublayer(imageLayer)
	}
}
