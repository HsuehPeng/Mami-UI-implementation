//
//  CheckoutInfo.swift
//  mamilove_interview
//
//  Created by Hsueh Peng Tseng on 2023/9/23.
//

import Foundation

struct CheckoutInfo: Codable {
	let payments: Payments
	let shippings: Shippings
	let preOrder: PreOrder

	enum CodingKeys: String, CodingKey {
		case payments, shippings
		case preOrder = "pre_order"
	}
}

// MARK: - Payments
struct Payments: Codable {
	let title: String
	let options: [PaymentsOption]
}

// MARK: - PaymentsOption
struct PaymentsOption: Codable {
	let title, icon: String
}

// MARK: - PreOrder
struct PreOrder: Codable {
	let title, description: String
}

// MARK: - Shippings
struct Shippings: Codable {
	let title: String
	let options: [ShippingsOption]
}

// MARK: - ShippingsOption
struct ShippingsOption: Codable {
	let isConvenienceStore: Bool
	let freeThreshold: Int
	let title: String
	let shippingFee: Int

	enum CodingKeys: String, CodingKey {
		case isConvenienceStore = "is_convenience_store"
		case freeThreshold = "free_threshold"
		case title
		case shippingFee = "shipping_fee"
	}
}
