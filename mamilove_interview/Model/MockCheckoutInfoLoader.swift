//
//  MockCheckoutInfoLoader.swift
//  mamilove_interview
//
//  Created by Hsueh Peng Tseng on 2023/9/23.
//

import Foundation

class MockCheckoutInfoLoader: CheckoutInfoLoader {
	func load(completion: @escaping (LoadResult) -> Void) {
		let payments = Payments(title: "付款", options: [
			PaymentsOption(title: "信用卡", icon: ""),
			PaymentsOption(title: "LINE PAY", icon: ""),
			PaymentsOption(title: "ATM", icon: ""),
			PaymentsOption(title: "貨到付款", icon: ""),
		])
		
		let shipping = Shippings(title: "配送", options: [
			ShippingsOption(isConvenienceStore: false, freeThreshold: 999, title: "宅配", shippingFee: 90),
			ShippingsOption(isConvenienceStore: true, freeThreshold: 999, title: "全家", shippingFee: 90),
			ShippingsOption(isConvenienceStore: true, freeThreshold: 999, title: "萊爾富", shippingFee: 90),
			ShippingsOption(isConvenienceStore: true, freeThreshold: 999, title: "OK Mart", shippingFee: 90),
		])
		
		let preOrder = PreOrder(title: "預購", description: "付款後 14 ~ 21 個工作天")
		
		let checkoutInfo = CheckoutInfo(payments: payments, shippings: shipping, preOrder: preOrder)
		
		// This is simulating the network call for data retrieval completing
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
			completion(.success(checkoutInfo))
		}
	}
}
