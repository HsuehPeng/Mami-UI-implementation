//
//  DashedLineView.swift
//  mamilove_interview
//
//  Created by Hsueh Peng Tseng on 2023/9/25.
//

import UIKit

class DashedLineView: UIView {
	override func draw(_ rect: CGRect) {
		let color = UIColor.lightGray.cgColor
		let context = UIGraphicsGetCurrentContext()!
		context.setStrokeColor(color)
		context.setLineWidth(1.0)
		context.setLineDash(phase: 0, lengths: [5, 4])

		context.move(to: CGPoint(x: 0, y: frame.size.height / 2))
		context.addLine(to: CGPoint(x: frame.size.width, y: frame.size.height))
		context.strokePath()
	}
}
