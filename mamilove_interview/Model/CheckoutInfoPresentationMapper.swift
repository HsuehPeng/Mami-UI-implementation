//
//  CheckoutInfoPresentationMapper.swift
//  mamilove_interview
//
//  Created by Hsueh Peng Tseng on 2023/9/25.
//

import Foundation

protocol CheckoutInfoPresentationMapper {
	func mapCheckoutInfo(for checkoutInfo: CheckoutInfo?) -> [InfoCellViewModel]
}
