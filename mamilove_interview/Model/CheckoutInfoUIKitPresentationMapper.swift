//
//  CheckoutInfoCellViewModelMapper.swift
//  mamilove_interview
//
//  Created by Hsueh Peng Tseng on 2023/9/25.
//

import UIKit

class CheckoutInfoUIKitPresentationMapper: CheckoutInfoPresentationMapper {
	func mapCheckoutInfo(for checkoutInfo: CheckoutInfo?) -> [InfoCellViewModel] {
		guard let checkoutInfo = checkoutInfo else { return [] }
		return [mapPayment(for: checkoutInfo.payments), mapShippings(for: checkoutInfo.shippings), mapPreOrder(for: checkoutInfo.preOrder)]
	}
}

extension CheckoutInfoUIKitPresentationMapper {
	private func mapPayment(for payment: Payments) -> InfoCellViewModel {
		let title = payment.title
		
		let subTitleAttribute: [NSAttributedString.Key: Any] = [
			.font: UIFont.systemFont(ofSize: 14),
			.foregroundColor: UIColor.black
		]
		let subTitleString = payment.options.map { option in
			option.title
		}.joined(separator: "・")
		
		let subTitle = NSAttributedString(string: subTitleString, attributes: subTitleAttribute)
		
		return InfoCellViewModel(title: title, subTitle: subTitle, isArrowButtonHidden: false)
	}
	
	private func mapShippings(for shippings: Shippings) -> InfoCellViewModel {
		let title = shippings.title
		
		let subTitleFirstAttribute: [NSAttributedString.Key: Any] = [
			.font: UIFont.systemFont(ofSize: 14),
			.foregroundColor: UIColor.black
		]
		
		let subTitleSecondAttribute: [NSAttributedString.Key: Any] = [
			.font: UIFont.systemFont(ofSize: 10),
			.foregroundColor: UIColor.gray
		]
		
		let subTitle = NSMutableAttributedString(string: "")
		
		for i in 0..<shippings.options.count {
			if i > 1 { break }
			
			let option = shippings.options[i]
			let optionTitle = NSMutableAttributedString(string: "\(option.title)  ", attributes: subTitleFirstAttribute)

			if i == 1 {
				let optionFreeThresholdString = NSAttributedString(string: "滿$\(option.freeThreshold)免運", attributes: subTitleSecondAttribute)
				optionTitle.append(optionFreeThresholdString)
				subTitle.append(optionTitle)
				break
			}
			
			let optionFreeThresholdString = NSAttributedString(string: "滿$\(option.freeThreshold)免運\n", attributes: subTitleSecondAttribute)
			optionTitle.append(optionFreeThresholdString)
			subTitle.append(optionTitle)
		}

		return InfoCellViewModel(title: title, subTitle: subTitle, isArrowButtonHidden: false)
	}
	
	private func mapPreOrder(for preOrder: PreOrder) -> InfoCellViewModel {
		let title = preOrder.title
		
		let subTitleAttribute: [NSAttributedString.Key: Any] = [
			.font: UIFont.systemFont(ofSize: 14),
			.foregroundColor: UIColor.black
		]
		
		let subTitle = NSAttributedString(string: preOrder.description, attributes: subTitleAttribute)

		return InfoCellViewModel(title: title, subTitle: subTitle, isArrowButtonHidden: true)
	}
}
